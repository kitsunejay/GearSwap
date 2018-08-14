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
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false

    include('Mote-TreasureHunter')

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
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('DT', 'Evasion')
    state.IdleMode:options('Normal', 'DT','Regen')

	-- Adoulin JSE Capes
	
	-- Ambuscade Capes
	gear.ambu_cape_wsd  = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.ambu_cape_tp   = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}

	-- Ru'an
	
	-- Reisenjima

	
    
	-- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
    
    set_lockstyle(5)
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')   
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        hands="Plunderer's Armlets +1",
        waist="Chaac Belt", 
        feet="Skulker's Poulaines +1"
    }
    sets.Kiting = {feet="Jute Boots +1"}

    sets.buff['Sneak Attack'] = {ammo="Yetshila",
        head="Pillager's Bonnet +2",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Epona's Ring",ring2="Apate Ring",
        back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

    sets.buff['Trick Attack'] = {ammo="Yetshila",
        head="Pillager's Bonnet +2",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Epona's Ring",ring2="Apate Ring",
        back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

    sets.buff.Doom = {waist="Gishdubar Sash"}
    
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Mummu Bonnet +1",
        body="Pillager's Vest +2",hands="Pillager's Armlets +1",ring1="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	    -- Fast Cast caps 80%; WHM JT: 0% /SCH LA 10%
        --      69/ 80% CCT+FC 

    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Herculean Helm",
        neck="Voltsurge Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        legs="Enif Cosciales"
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {head=gear.taeon_head_snap}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Skormoth Mask",neck="Fotia Gorget", ear1="Sherida Earring",ear2="Cessance Earring",
        body="Abnoba Kaftan",ring1="Rajas Ring",ring2="Apate Ring",
        back=gear.ambu_cape_wsd, waist="Fotia Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Ginsen",
		body="Meghanada Cuirie +2",hands="Meghanada Gloves +2", ring2="Meghanada Ring",
		waist="Eschan Stone", feet="Meghanada Jambeaux +2"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})

	--Evisceration - 50% DEX - fTP transfered - Chance of Crit with TP
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        head="Adhemar Bonnet",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Cessance Earring",
        body="Abnoba Kaftan",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
        waist="Fotia Belt",
        feet=gear.herc_feet_cchance
    })
    --sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    --sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {back="Kayapa Cape",waist="Fotia Belt"})
    --sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    --sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    --sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

	--Rudra's Storm - 80% DEX - 5.0	--> 10.19 --> 13
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS,{
        ammo="Falcon Eye",
        head="Pillager's Bonnet +2",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",feet="Meghanada Jambeaux +2",
        waist="Grunfeld Rope",
    })
		
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Ginsen", back="Letalis Mantle"})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +2",ear1="Sherida Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +2",ear1="Sherida Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +2",legs="Pillager's Culottes +1"})

    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hermetic Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Acumen Ring",
        back="Izdubar Mantle",waist="Eschan Stone",legs=gear.herc_legs_mabwsd,feet="Herculean Boots"}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Whirlpool Mask",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Calamitous Earring",
        body="Pillager's Vest +2",hands="Leyline Gloves",
        back="Xucau Mantle",waist="Cetl Belt",legs="Mummu Kecks +2",feet="Herculean Boots"}

    -- Specific spells

    -- Ranged gear
    sets.midcast.RA = {
        head="Meghanada Visor +2",neck="Erudition Necklace",ear1="Telos Earring",ear2="Enervating Earring",
        body="Mummu Jacket +2",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Apate Ring",
        waist="Yemaya Belt",legs=gear.adhemar_legs_tp,feet="Meghanada Jambeaux +2"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Yamarang",
        head="Pillager's Bonnet +2",neck="Twilight Torque",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.ambu_cape_tp,waist="Flume Belt",legs="Mummu Kecks +2",feet="Jute Boots +1"}
		
    sets.idle.Town = {ammo="Yamarang",
        head="Skormoth Mask",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Pillager's Vest +2",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.ambu_cape_wsd,waist="Eschan Stone",legs="Samnuha Tights",feet="Jute Boots +1"}
		
    sets.idle.Weak = {ammo="Yamarang",
        head="Pillager's Bonnet +2",neck="Twilight Torque",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Vocane Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Mummu Kecks +2",feet="Jute Boots +1"}


    -- Defense sets

    sets.defense.PDT = {ammo="Ginsen",
        head="Meghanada Visor +2",neck="Twilight Torque",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Vocane Ring",
        back="Xucau Mantle",waist="Eschan Stone",legs="Mummu Kecks +2",feet="Herculean Boots"}

    sets.defense.MDT = {ammo="Ginsen",
        head="Meghanada Visor +2",neck="Twilight Torque",
        body="Meghanada Cuirie +2",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Vocane Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Mummu Kecks +2",feet="Meghanada Jambeaux +2"}


    --------------------------------------
    -- Melee sets
    --------------------------------------
    -----   DW  -------
    --         15%      30%     Cap(44%)
    -- T3(25)   42      31	    11
    -- T4(30)   37      26	    6
    -------------------
    -- Normal MH/OH
    -- Aeneas // Shijo
        --  27/25% Haste
        --  10/11% DW (assumuing capped)
        --  1020 ACC
        --  1024 ATK
        --  34  STP
        --  25  TA
        --  11  DA
        --      %Crit

    -- Normal melee group
    -- 49% DW
    sets.engaged = {ammo="Yamarang",
        --head="Skormoth Mask",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Pillager's Vest +2",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.ambu_cape_tp,waist="Windbuffet Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    
    -- 11% DW
    sets.engaged.MaxHaste = {ammo="Yamarang",
        --head="Skormoth Mask",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.ambu_cape_tp,waist="Windbuffet Belt",legs="Samnuha Tights",feet="Herculean Boots"}

    -- 31% DW
    sets.engaged.HighHaste = {ammo="Yamarang",
        --head="Skormoth Mask",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.ambu_cape_tp,waist="Windbuffet Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    
    -- 20% DW
    sets.engaged.MidHaste = {ammo="Yamarang",
        --head="Skormoth Mask",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.ambu_cape_tp,waist="Windbuffet Belt",legs="Samnuha Tights",feet="Herculean Boots"}

    -- 42% DW
     sets.engaged.LowHaste = {ammo="Yamarang",
        --head="Skormoth Mask",
        head="Adhemar Bonnet",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.ambu_cape_tp,waist="Windbuffet Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    -------------------------------------------------------------------------------------------------
        --  27/25% gear haste
        --  27/11% DW
        --  1093 ACC
        --  1099 ATK
        --    STP
        --    TA
        --    DA
        --      %Crit
    sets.engaged.Acc = {ammo="Yamarang",
        head="Skormoth Mask",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Epona's Ring",ring2="Meghanada Ring",
        back=gear.ambu_cape_tp,waist="Eschan Stone",legs="Samnuha Tights",feet="Herculean Boots"}
    sets.engaged.DT = {ammo="Yamarang",
        head="Skormoth Mask",neck="Twilight Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.ambu_cape_tp,waist="Eschan Stone",legs="Mummu Kecks +2",feet=gear.herc_feet_cchance}
    sets.engaged.Acc.DT = {ammo="Yamarang",
        head="Whirlpool Mask",neck="Twilight Torque",ear1="Sherida Earring",ear2="Telos Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.ambu_cape_tp,waist="Hurch'lan Sash",legs="Mummu Kecks +2",feet=gear.herc_feet_cchance}


    sets.precast.FC['Trust'] = sets.engaged
    sets.midcast['Trust'] = sets.engaged
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
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
	local res = require('resources')
    local info = windower.ffxi.get_info()
    local zone = res.zones[info.zone].name
    -- if zone:match('Adoulin') then
        --idleSet = set_combine(idleSet, sets.Adoulin)
    --end
    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
            msg = msg .. ' ' .. v .. ''
        end
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


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)
    
end