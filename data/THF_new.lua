-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
--[[
    Custom commands:
 
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
     
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
 
--]]
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.HasteMode = M{['description']='Haste Mode', 'Haste I', 'Haste II'}
    state.MarchMode = M{['description']='March Mode', 'Trusts', '3', '7', 'Honor'}
     
    include('Mote-TreasureHunter')
    determine_haste_group()
 
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'MaxAcc')
    state.HybridMode:options('Normal', 'PDT') -- 'Evasion'
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT') -- 'Evasion'
    state.IdleMode:options('Normal', 'Regen', 'STP')
     
    state.CP = M(false, "Capacity Points Mode")
 
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind @` input /ja "Despoil" <t>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
    send_command('bind delete input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^delete input /ws "Mandalic Stab" <t>')
    send_command('bind end input /ws "Evisceration" <t>')
    send_command('bind ^end input /ws "Exenterator" <t>')
    send_command('bind !f9 gs c cycle HasteMode')
    send_command('bind !f10 gs c cycle MarchMode')
    send_command('bind @c gs c toggle CP')
     
    if player.sub_job == 'WAR' then
        send_command('bind home input /ja "Berserk" <me>')
    elseif player.sub_job == 'DRK' then
        send_command('bind home input /ja "Last Resort" <me>')
        send_command('bind ` input /ma "Stun" <t>')
    elseif player.sub_job == 'RUN' then
        send_command('bind ` input /ma "Flash" <t>')  
    end 
 
    select_default_macro_book()
    set_lockstyle()
     
    target_distance = 6.9 -- Set Default Distance Here --
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind `')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^-')
    send_command('unbind !-')
    send_command('unbind @-')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind @=')
    send_command('unbind delete')
    send_command('unbind end')
    send_command('unbind home')
    send_command('unbind ^delete')
    send_command('unbind ^end')
    send_command('unbind ^home')
    send_command('unbind !delete')
    send_command('unbind !end')
    send_command('unbind !home')
    send_command('unbind @delete')
    send_command('unbind @end')
    send_command('unbind @home')
    send_command('unbind !q')
    send_command('unbind @c')
    send_command('unbind !w')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
 
    sets.TreasureHunter = {hands="Plunderer's Armlets +1",feet="Skulker's Poulaines +1"}
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    sets.Kiting = {feet="Jute Boots +1"}
 
    sets.buff['Sneak Attack'] = {ammo="Yetshila",
        head="Adhemar Bonnet",neck="Caro Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Abnoba Kaftan",hands="Plunderer's Armlets +1",ring1="Ramuh Ring +1",ring2="Epona's Ring",
        back=thf_crit,waist="Chaac Belt",legs="Pillager's Culottes +3",feet="Skulker's Poulaines +1"}
 
    sets.buff['Trick Attack'] = set_combine(sets.buff['Sneak Attack'], {ring1="Garuda Ring"})
 
    -- Actions we want to use to tag TH.
    sets.precast.Step = set_combine(sets.TreasureHunter, {})
    sets.precast.Flourish1 = set_combine(sets.TreasureHunter, {})
    sets.precast.JA.Provoke = set_combine(sets.TreasureHunter, {})
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Precast sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Assassins Charge'] = {feet="Plunderer's Poulaines +1"}
    sets.precast.JA['Ambush'] = {}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest"}
    sets.precast.JA['Steal'] = {hands="Pillager's Armlets +1",legs="Pillager's Culottes +3",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {feet="Skulker's Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +1"}
    sets.precast.JA['Sneak Attack'] = set_combine(sets.buff['Sneak Attack'])
    sets.precast.JA['Trick Attack'] = set_combine(sets.buff['Trick Attack'])
    sets.precast.JA['Mug'] = set_combine(sets.precast.WS, {ammo="Jukukik Feather",head="Adhemar Bonnet",ear1="Suppanomimi",ear2="Sherida Earring",
        waist="Grunfeld Rope",legs=herc_legs_DEXCRIT,feet=herc_feet_TA})
     
    organizer_items = {
        "Taming Sari",
        "Raider's Boomerang",
        "Aeneas",
        "Oneiros Knife"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {waist="Gishdubar Sash"} --ring1="Kunaji Ring",
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",neck="Orunmila's Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        head=herc_head_DT,body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Veneficium Ring"}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
    -- Ranged snapshot gear
    sets.precast.RA = {}
 
    ------------------------------------------------------------------------------------------
    ------------------------------------ Weaponskill sets ------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Jukukik Feather",
         head="Adhemar Bonnet",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
         body="Meghanada Cuirie +2",hands="Adhemar Wristbands",ring1="Regal Ring",ring2="Ilabrat Ring",
         back=thf_crit,waist="Wanion Belt",legs="Samnuha Tights",feet="Lustratio Leggings +1"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Falcon Eye",head="Pillager's Bonnet +3",waist="Grunfeld Rope"})
    sets.precast.WS.SA = set_combine(sets.precast.WS,{})
    sets.precast.WS.SA.Acc = set_combine(sets.precast.WS.SA,{})
    sets.precast.WS.TA = set_combine(sets.precast.WS.SA,{})
    sets.precast.WS.TA.Acc = set_combine(sets.precast.WS.TA,{})
    sets.precast.WS.SATA = set_combine(sets.precast.WS.SA,{})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
     
    ------------------------------------------------------------------------------------------
    ----------------------------------- Rudra's Storm sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Falcon Eye",
        head="Pillager's Bonnet +3",ear2="Sherida Earring",body="Adhemar Jacket",hands="Meghanada Gloves +2",
        waist="Grunfeld Rope",legs="Lustratio Subligar +1"})         
    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {})  
    sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'], {ammo="Yetshila",
        body="Meghanada Cuirie +2",waist="Artful Belt +1",back=thf_WSD})         
    sets.precast.WS['Rudra\'s Storm'].SA.Acc = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {})     
    sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {})
    sets.precast.WS['Rudra\'s Storm'].TA.Acc = set_combine(sets.precast.WS['Rudra\'s Storm'].TA, {})
    sets.precast.WS['Rudra\'s Storm'].SATA = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {})
     
    ------------------------------------------------------------------------------------------
    ----------------------------------- Mandalic Stab sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS["Rudra's Storm"], {})         
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {})    
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})       
    sets.precast.WS['Mandalic Stab'].SA.Acc = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})   
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
    sets.precast.WS['Mandalic Stab'].TA.Acc = set_combine(sets.precast.WS["Rudra's Storm"].TA, {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS["Rudra's Storm"].SA, {})
     
    ------------------------------------------------------------------------------------------
    ------------------------------------ Evisceration sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",head="Pillager's Bonnet +3",neck="Fotia Gorget",ear2="Sherida Earring",
        ring1="Begrudging Ring",waist="Fotia Belt",legs="Lustratio Subligar +1"})    
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Falcon Eye",waist="Grunfeld Rope"})        
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})    
    sets.precast.WS['Evisceration'].SA.Acc = set_combine(sets.precast.WS['Evisceration'].SA, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].SA, {})
    sets.precast.WS['Evisceration'].TA.Acc = set_combine(sets.precast.WS['Evisceration'].TA, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].SA, {})
     
    ------------------------------------------------------------------------------------------
    ------------------------------------ Exenterator sets ------------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
         neck="Fotia Gorget",ear1="Telos Earring",ear2="Sherida Earring",
         hands="Meghanada Gloves +2",ring1="Garuda Ring",ring2="Ilabrat Ring",
         back=thf_WSD,waist="Fotia Belt",legs="Meghanada Chausses +2",feet=herc_feet_STRWSD})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Yetshila"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].SA, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {})
     
    ------------------------------------------------------------------------------------------
    ----------------------------- Mercy Stroke sets (RIP Mandau) -----------------------------
    ------------------------------------------------------------------------------------------
    --[[sets.precast.WS['Mercy Stroke'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Lustratio Cap",ear1="Vulcan's Pearl",hands=herc_hands_STRWSD,
        ring1="Shukuyu Ring",ring2="Rajas Ring",back="Buquwik Cape",legs=herc_legs_STRWSD})
    sets.precast.WS['Mercy Stroke'].Acc = set_combine(sets.precast.WS['Mercy Stroke'], {})
    sets.precast.WS['Mercy Stroke'].SA = set_combine(sets.precast.WS['Mercy Stroke'], {})    
    sets.precast.WS['Mercy Stroke'].SA.Acc = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})     
    sets.precast.WS['Mercy Stroke'].TA = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})
    sets.precast.WS['Mercy Stroke'].TA.Acc = set_combine(sets.precast.WS['Mercy Stroke'].TA, {})
    sets.precast.WS['Mercy Stroke'].SATA = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})
    --]]
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Midcast sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    sets.midcast.FastRecast = {}
 
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Staunch Tathlum",
        head=herc_head_DT,neck="Magoraga Beads",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meghanada Chausses +2",feet=herc_feet_PDT}
 
    -- Ranged gear
    sets.midcast.RA = {}
    sets.midcast.RA.Acc = {}
 
    ------------------------------------------------------------------------------------------
    --------------------------------------- Idle sets ----------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle = {ammo="Staunch Tathlum",
        head=herc_head_DT,neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands=herc_hands_DT,ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Moonbeam Cape",waist="Flume Belt",legs="Meghanada Chausses +2",feet="Jute Boots +1"}
         
    sets.idle.Regen = set_combine(sets.idle, {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"})
 
    sets.idle.Town = {ammo="Yamarang",
        head="Pillager's Bonnet +3",neck="Erudition Necklace",ear1="Telos Earring",ear2="Sherida Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Petrov Ring",ring2="Epona's Ring",
        back=thf_STP,waist="Windbuffet Belt +1",legs="Pillager's Culottes +3",feet="Jute Boots +1"}
 
    sets.idle.Weak = {ammo="Staunch Tathlum",
        head=herc_head_DT,neck="Wiglen Gorget",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands=herc_hands_DT,ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meghanada Chausses +2",feet=herc_feet_DT}
         
    sets.idle.STP = {ammo="Yamarang",
        head=herc_head_DT,neck="Erudition Necklace",ear1="Telos Earring",ear2="Sherida Earring",
        body=herc_body_TA,hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Ilabrat Ring",
        back=thf_STP,waist="Reiki Yotai",legs="Samnuha Tights",feet=herc_feet_PDT}  
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Defense sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    sets.defense.Evasion = set_combine(sets.defense.PDT, {})
 
    sets.defense.PDT = {ammo="Staunch Tathlum",
        head=herc_head_DT,neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands=herc_hands_DT,ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meghanada Chausses +2",feet=herc_feet_PDT}
 
    sets.defense.MDT = {ammo="Staunch Tathlum",
        head=herc_head_DT,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Pillager's Vest +2",hands=herc_hands_DT,ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Flume Belt",legs="Samnuha Tights",feet="Jute Boots +1"}
 
    ----------------------------------------------------------------------------------------
    ------------------------------------- Melee sets ---------------------------------------
    ----------------------------------------------------------------------------------------
 
    -- Normal melee group
    -- THF Native DW Trait: 25% DWIII + 5% 550JP Gift
    -- No Haste (Need 44 DW)
    -- (Aeneas/Sari) Accuracy 1080, Attack 1140
    sets.engaged = {ammo="Yamarang",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Telos Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=thf_STP,waist="Reiki Yotai",legs="Samnuha Tights",feet=herc_feet_TA}
    -- (Aeneas/Sari) Accuracy 1097, Attack 1154
    sets.engaged.MidAcc = set_combine (sets.engaged, {neck="Combatant's Torque",hands="Adhemar Wristbands"})    
    -- (Aeneas/Sari) Accuracy 1189, Attack 1163
    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Pillager's Bonnet +3",ear2="Dignitary's Earring",ring1="Regal Ring",waist="Grunfeld Rope"})
    -- (Aeneas/Sari) Accuracy 1286, Attack 1141
    sets.engaged.MaxAcc = set_combine(sets.engaged.HighAcc, {
        neck={name="Combatant's Torque", priority=2},
        body="Pillager's Vest +2",ring2={name="Ramuh Ring +1", priority=7},
        legs={name="Meghanada Chausses +2", priority=5},feet=herc_feet_ACC})    
     
    -- Normal melee group, 15% Haste (Need 37 DW) 
    sets.engaged.MidHaste = set_combine(sets.engaged, {})
    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.MidAcc, {})
    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.HighAcc, {})
    sets.engaged.MaxAcc.MidHaste = set_combine(sets.engaged.MaxAcc, {})
     
    -- Normal melee group, 30% Haste (26 DW)
    sets.engaged.HighHaste = set_combine(sets.engaged.MidHaste, {})
    sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.MidAcc, {})
    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.HighAcc, {})
    sets.engaged.MaxAcc.HighHaste = set_combine(sets.engaged.MaxAcc, {})
     
    -- Normal melee group, Capped Haste (Need 6 DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged.HighHaste, {
        ear2="Sherida Earring",hands="Adhemar Wristbands",waist="Windbuffet Belt +1",legs="Pillager's Culottes +3"}) --Pillager's Vest +3, Reiki Yotai
    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {head="Skulker's Bonnet +1",neck="Combatant's Torque",body="Pillager's Vest +2"})
    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.HighAcc, {})
    sets.engaged.MaxAcc.MaxHaste = set_combine(sets.engaged.MaxAcc, {})
     
    -- Accuracy: 1216
    sets.engaged.PDT = {ammo="Yamarang",
        head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Moonbeam Ring",
        back=thf_STP,waist="Reiki Yotai",legs="Meghanada Chausses +2",feet=herc_feet_ACC}
    sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.PDT, {})
     
    sets.CP = {back="Mecisto. Mantle"}
     
    ------------------------------------------------------------------------------------------
    ----------------------------------- No longer used sets ----------------------------------
    ------------------------------------------------------------------------------------------
     
    --sets.OneirosRing = {ring1="Oneiros Ring"} 
    --sets.DaytimeAmmo = {ammo="Tengu-no-Hane"}
         
    -- Mod set for trivial mobs (Thaumas Coat)
    --sets.engaged.Fodder = set_combine(sets.engaged, {body="Thaumas Coat"})
 
    --[[sets.engaged.Evasion = {ammo="Yamarang",
        head=herc_head_DT,neck="Erudition Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=herc_hands_TA,ring1="Petrov Ring",ring2="Epona's Ring",
        back="Canny Cape",waist="Windbuffet Belt +1",legs="Meghanada Chausses +2",feet="Skulker's Poulaines +1"}
    sets.engaged.MaxAcc.Evasion = set_combine(sets.engaged.Evasion, {ammo="Falcon Eye",
        head="Skulker's Bonnet +1",neck="Erudition Necklace",body="Pillager's Vest +2",hands="Plunderer's Armlets +1"})
    ]]--
     
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_pretarget(spell,action)
    if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       cancel_spell()
       add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       return
    end
end 
 
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Berserk' then 
        if buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('input /ja Aggressor <me>')
        end 
    end     
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") then
       if buffactive.Silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
       end
    end 
    if spell.type == 'WeaponSkill' then
        if (spell.english == "Rudra's Storm" or spell.english == "Evisceration") and player.tp > 2900 then
            equip({ear1="Ishvara Earring",ear2="Sherida Earring"})
        end             
    end
end
 
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and buffactive.Madrigal then
        equip({ear2="Kuwunga Earring"})
    end
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end
 
-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end
 
-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    determine_haste_group()
end
 
function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode
 
    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end
 
    return wsmode
end
 
 
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
 
    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end
 
 
function customize_idle_set(idleSet)
    --if player.hpp <= 75 then
     --   idleSet = set_combine(idleSet, sets.ExtraRegen)
    --end       
     
    if world.area:contains('Adoulin') then
        idleSet = set_combine(sets.idle.Town, {body="Councilor's Garb"})
    end
     
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
 
    return idleSet
end
 
 
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end 
    if (world.time >= 360 and world.time < 1080) and state.OffenseMode.value == 'Acc' then
       meleeSet = set_combine(meleeSet, sets.DaytimeAmmo)
    end
    --if player.mp >= 100 then
    --  meleeSet = set_combine(meleeSet, sets.OneirosRing)
    --end  
     
    return meleeSet
end
 
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
    determine_haste_group()
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
     
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
     
    msg = msg .. ': '
     
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
     
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
     
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
 
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
     
    msg = msg .. ', TH: ' .. state.TreasureMode.value
     
    msg = msg .. ', Haste: ' .. state.HasteMode.value
     
    msg = msg .. ', March: ' .. state.MarchMode.value
     
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
 
 
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end
 
 
-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end
 
function determine_haste_group()
    -- Gearswap can't detect the difference between Hastes & Marches
    -- so use alt+F9 to manually set Haste and alt+F10 to manually set March spell levels.
 
    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%
     
    -- DW traits
        -- I = 10% (nin 10, dnc 20, thf 83)
        -- II = 15% (nin 25, dnc 40, thf 87)
        -- III = 25% (nin 45, dnc 60, thf 98)
        -- IV = 30% (nin 60, dnc 85, thf w/550 JP)
        -- V = 35% (nin 85)
     
    -- Magic Haste Cap
        -- Haste cap with 10 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.10 = 26 DW needed
        -- Haste cap with 15 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.15 = 21 DW needed
        -- Haste cap with 25 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.25 = 11 DW needed
        -- Haste cap with 30 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.30 = 6 DW needed
        -- Haste cap with 35 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.35 = 1 DW needed
     
    classes.CustomMeleeGroups:clear()
    h = 0
    -- Spell Haste 15/30
    if buffactive[33] then
        if state.HasteMode.value == 'Haste I' then
            h = h + 15
        elseif state.HasteMode.value == 'Haste II' then
            h = h + 30
        end
    end
    -- Geo Haste 30
    if buffactive[580] then
            h = h + 35
    end 
    -- Mighty Guard 15
    if buffactive[604] then
        h = h + 15
    end
    -- Embrava 15
    if buffactive.embrava then
        h = h + 15
    end
    -- March(es) 
    if buffactive.march then
        if state.MarchMode.value == 'Honor' then
            if buffactive.march == 2 then
                h = h + 27 + 16
            elseif buffactive.march == 1 then
                h = h + 16
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == 'Trusts' then
            if buffactive.march == 2 then
                h = h + 26
            elseif buffactive.march == 1 then
                h = h + 16
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == '7' then
            if buffactive.march == 2 then
                h = h + 27 + 17
            elseif buffactive.march == 1 then
                h = h + 27
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == '3' then
            if buffactive.march == 2 then
                h = h + 13.5 + 20.6
            elseif buffactive.march == 1 then
                h = h + 20.6
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        end
    end
  
    -- Determine CustomMeleeGroups
    if h >= 15 and h < 30 then 
        classes.CustomMeleeGroups:append('MidHaste')
        add_to_chat('Haste Group: 15% -- From Haste Total: '..h)
    elseif h >= 30 and h < 35 then 
        classes.CustomMeleeGroups:append('HighHaste')
        add_to_chat('Haste Group: 30% -- From Haste Total: '..h)
    elseif h >= 35 and h < 40 then 
        classes.CustomMeleeGroups:append('HighHaste')
        add_to_chat('Haste Group: 35% -- From Haste Total: '..h)
    elseif h >= 40 then
        classes.CustomMeleeGroups:append('MaxHaste')
        add_to_chat('Haste Group: Max -- From Haste Total: '..h)
    end
     
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end
 
function set_lockstyle()
    send_command('wait 6;input /lockstyleset 1')
end