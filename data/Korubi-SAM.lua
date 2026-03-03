-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')

    -- auto-inventory swaps
    include('organizer-lib')
    
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

    --update_offense_mode()    
    determine_haste_group()
    
    include('Mote-TreasureHunter')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDL', 'SubtleBlow', 'Proc')
    state.HybridMode:options('Normal', 'DT', 'MEVA', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL', 'Proc')
    state.PhysicalDefenseMode:options('Turtle', 'Reraise')
    state.IdleMode:options('Normal', 'DT', 'MEVA','Regain', 'Regen')
    
    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Third Eye" <me>')
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    set_lockstyle(25)

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
    send_command('unbind ^=')

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        waist="Chaac Belt"
    }
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back=gear.smertrios_wsd}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
    sets.precast.JA['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Mpaca's Cap",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Sakonji Domaru +3",hands="Kasuga Kote +3",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.smertrios_wsd,waist="Sailfi Belt +1",legs="Wakido Haidate +4",feet="Nyame Sollerets"}
    sets.precast.WS.PDL = {ammo="Knobkierrie",
        head="Mpaca's Cap",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Sakonji Domaru +3",hands="Kasuga Kote +3",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.smertrios_wsd,waist="Sailfi Belt +1",legs="Wakido Haidate +4",feet="Nyame Sollerets"}
    sets.precast.WS.Acc = {ammo="Knobkierrie",
        head="Mpaca's Cap",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Sakonji Domaru +3",hands="Kasuga Kote +3",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.smertrios_wsd,waist="Sailfi Belt +1",legs="Wakido Haidate +4",feet="Nyame Sollerets"}

    sets.precast.WS["Tachi: Ageha"] = {ammo="Pemphredo Tathlum",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Crepuscular Earring",ear2="Dignitary's Earring",
        body="Kasuga Domaru +2",hands="Kasuga Kote +3",ring1="Stikini Ring +1",ring2="Metamorph Ring +1",
        back=gear.smertrios_wsd,waist="Fotia Belt",legs="Kasuga Haidate +2",feet="Kasuga Sune-ate +2"}
 
    sets.precast.WS['Impulse Drive'] = {ammo="Knobkierrie",
        head="Mpaca's Cap",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Sakonji Domaru +3",hands="Kasuga Kote +3",ring1="Niqmaddu Ring",ring2="Begrudging Ring",
        back=gear.smertrios_crit,waist="Sailfi Belt +1",legs="Wakido Haidate +4",feet="Nyame Sollerets"}
    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Impulse Drive']

    sets.precast.WS["Tachi: Jinpu"] = {ammo="Knobkierrie",
        head="Nyame Helm",neck="Samurai's Nodowa +2",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.smertrios_wsd,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.precast.WS["Tachi: Koki"] = sets.precast.WS["Tachi: Jinpu"]
    sets.precast.WS["Tachi: Kagero"] = sets.precast.WS["Tachi: Jinpu"]    
   
    sets.precast.WS["Tachi: Jinpu"].Mod = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Fotia Gorget",ear1="Crepuscular Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Apate Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_wsd,waist="Fotia Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-Ate +1"}

    sets.precast.MaxTP = {head="Nyame Helm", ear2="Ishvara Earring"}
    
    sets.precast.FC = {
        ammo="Sapience Orb",
        head="Nyame Helm",
        body="Sacro Breastplate",
        hands="Leyline Gloves",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Voltsurge Torque",
        waist="Ioskeha Belt +1",
        left_ear="Loquac. Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Rahab Ring",
        right_ring="Gelatinous Ring +1",
        back="Shadow Mantle",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Sets to return to when not performing an action.    

    -- Idle sets
    sets.idle.Town = {ammo="Crepuscular Pebble",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +2",ear1="Thrud Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Shneddick Ring",ring2="Cornelia's Ring",
        back=gear.smertrios_wsd,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    
    sets.idle.Field = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Shneddick Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    sets.idle.Field.Regen = {ammo="Staunch Tathlum +1",
        head="Crepuscular Helm",neck="Loricate Torque +1",ear1="Alabaster Earring",ear2="Odnowa Earring +1",
        body="Sacro Breastplate",hands="Nyame Gauntlets",ring1="Shneddick Ring",ring2="Chirich Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.Field.Regain = {ammo="Staunch Tathlum +1",
        head="Wakido Kabuto +3",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Shneddick Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.Field.MEVA = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Platinum Moogle Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Platinum Moogle Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    -- Defense sets
    sets.defense.Turtle = {ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Platinum Moogle Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.hp = {
        main="Masamune",
        sub="Utu Grip",
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Unmoving Collar +1",
        waist="Plat. Mog. Belt",
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Eihwaz Ring",
        right_ring="Gelatinous Ring +1",
        back="Shadow Mantle"
    }

    sets.Kiting = {ring1="Shneddick Ring"}

    sets.Reraise = {head="Crepuscular Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Dedition Earring",ear2="Kasuga Earring",
        body="Kasuga Domaru +2",hands="Tatenashi Gote +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back="Takaha Mantle",waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Ryuo Sune-ate +1"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Schere Earring",ear2="Telos Earring",
        body="Kasuga Domaru +2",hands="Tatenashi Gote +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Ryuo Sune-ate +1"}
    sets.engaged.DT = {ammo="Ginsen",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Dedition Earring",ear2="Kasuga Earring",
        body="Kasuga Domaru +2",hands="Tatenashi Gote +1",ring1="Niqmaddu Ring",ring2="Murky Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Ryuo Sune-ate +1"}
    sets.engaged.MEVA = {ammo="Ginsen",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Dedition Earring",ear2="Kasuga Earring",
        body="Kasuga Domaru +2",hands="Nyame Gauntlets",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Kendatsuba Sune-ate +1"}
    sets.engaged.Acc.DT = {ammo="Ginsen",
        head="Kasuga Kabuto +2",neck="Samurai's Nodowa +2",ear1="Schere Earring",ear2="Telos Earring",
        body="Kasuga Domaru +2",hands="Tatenashi Gote +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Ryuo Sune-ate +1"}
    sets.engaged.SubtleBlow = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +2",ear1="Schere Earring",ear2="Dignitary's Earring",
        body="Dagon Breastplate",hands="Kendatsuba Tekko +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back="Takaha Mantle",waist="Ioskeha Belt +1",legs="Kasuga Haidate +2",feet="Ryuo Sune-ate +1"}
    
    sets.engaged.PDL = sets.engaged

    sets.buff.Sekkanoki = {hands="Kasuga Kote +3"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell)
    checkblocking(spell)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end

        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    --update_offense_mode()
    determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_offense_mode()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

function job_buff_change(buff,gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
                send_command('timers create "AM3" 180 down spells/00899.png;wait 150;input /echo AM3 [WEARING OFF IN 30 SEC.];wait 15;input /echo AM3 [WEARING OFF IN 15 SEC.];wait 5;input /echo AM3 [WEARING OFF IN 10 SEC.]')
                add_to_chat(123,' ---   AM3: [ON]   ---')
        else
                send_command('timers delete "AM3"')
                add_to_chat(123,' ---   AM3: [OFF]   ---')
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 11)
    else
        set_macro_page(1, 11)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
