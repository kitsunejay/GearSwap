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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc','Acc')
    state.HybridMode:options('Normal', 'MEVA', 'DT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'LowAcc', 'HighAcc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.IdleMode:options('Normal', 'MEVA', 'DT','Regain', 'Regen')
    
    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Third Eye" <me>')
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    set_lockstyle(20)
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
    -- Organizer items

    organizer_items = {
        sushi="Sublime Sushi",
        shihei="Shihei",
        remedy="Remedy"
    }

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt", 
    }
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +3",back=gear.smertrios_wsd}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
    sets.precast.JA['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head=gear.valorous_head_wsd,neck="Samurai's Nodowa +1",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Sakonji Domaru +3",hands=gear.valorous_hands_wsd,ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.smertrios_wsd,waist="Sailfi Belt +1",legs="Wakido Haidate +3",feet=gear.valorous_feet_wsd}
    sets.precast.WS.LowAcc = set_combine(sets.precast.WS,{
        waist="Ioskeha Belt +1"})
    sets.precast.WS.HighAcc = set_combine(sets.precast.WS,{
        hands="Wakido Kote +3",
        waist="Ioskeha Belt +1"})

    sets.precast.WS["Tachi: Ageha"] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Flamma Korazin +2",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.smertrios_wsd,waist="Fotia Belt",legs="Flamma Dirs +2",feet="Flamma Gambieras +2"}
    
    sets.precast.WS["Tachi: Jinpu"] = sets.precast.WS
    sets.precast.WS["Tachi: Jinpu"].Mod = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Flamma Korazin +2",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.smertrios_wsd,waist="Fotia Belt",legs="Flamma Dirs +2",feet="Flamma Gambieras +2"}
    
    sets.precast.MaxTP = {ear2="Ishvara Earring"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +2",ear1="Thrud Earring",ear2="Telos Earring",
        body="Dagon Breastplate",hands="Wakido Kote +3",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Danzo Sune-Ate"}
    
    sets.idle.Field = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Kendatsuba Samue +1",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    
    sets.idle.Field.Regen = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Sanctity Necklace",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Hizamaru Haramaki +2",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    
    sets.idle.Field.Regain = {ammo="Staunch Tathlum +1",
        head="Wakido Kabuto +3",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Karieyh Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}  

    sets.idle.Field.MEVA = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Kendatsuba Samue +1",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Wakido Domaru +3",hands="Sakonji Kote +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}


    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Dedition Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Ryuo Hakama",feet="Ryuo Sune-ate +1"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    sets.engaged.DT = {ammo="Staunch Tathlum +1",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Ryuo Sune-ate +1"}
    sets.engaged.MidAcc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Ryuo Sune-ate +1"}
    sets.engaged.MEVA = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"}
    sets.engaged.Acc.DT = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Samurai's Nodowa +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Wakido Domaru +3",hands="Wakido Kote +3",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Flamma Gambieras +2"}
    sets.engaged.MidAcc.DT = {ammo="Staunch Tathlum +1",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kendatsuba Samue +1",hands="Wakido Kote +3",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt +1",legs="Kendatsuba Hakama +1",feet="Ryuo Sune-ate +1"}

    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate +1"}
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
