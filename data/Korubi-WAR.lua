-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'MDT','Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('DT', 'Reraise')
    state.IdleMode:options('Normal', 'DT','Regen')

    update_combat_form()
        
	-- Ambuscade Capes
    gear.cichol_ws 	={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
    gear.cichol_upheaval = {name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
    gear.cichol_tp  ={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()

    set_lockstyle(9)

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1",body="Pummeler's Lorica +3",back=gear.cichol_tp}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}

    sets.precast.JA['Retaliation'] = {feet="Boii Calligae +1"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica"}

    sets.precast.FC['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    sets.midcast['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
         
    -- Misc
    sets.engaged.Hybrid = {
        head="Volte Salade",
        legs="Volte Brayettes"
    }

    sets.MightyStrikes = {
        feet="Boii Calligae +1"
    }
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Greatsword

    --  40% STR / 40% VIT
    sets.precast.WS['Scourge'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Cessance Earring",
        body="Pummeler's Lorica +3",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}

    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Flamma Gambieras +2"}

    sets.precast.WS['Resolution'].Acc = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    -- Great Axe
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        head="Agoge Mask +3",
        body="Pummeler's Lorica +3",hands=gear.odyssean_hands_upheaval,
        back=gear.cichol_upheaval,waist="Ioskeha Belt +1",feet="Sulevia's Leggings +2"})  
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {        
        head="Agoge Mask +3",
        body="Pummeler's Lorica +3",hands=gear.odyssean_hands_upheaval,
        back=gear.cichol_upheaval,waist="Ioskeha Belt +1",feet="Sulevia's Leggings +2"})

    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        hands="Flamma Manopolas +2"})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {        
        ammo="Yetshila",
        hands="Flamma Manopolas +2"})
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

    -- Axe

    sets.precast.WS['Decimation'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Telos Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Flamma Gambieras +2"}

    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {ammo="Ginsen",     
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Volte Brayettes",feet="Hermes' Sandals"}
    
    sets.idle.Field = {ammo="Staunch Tathlum",  
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Hermes' Sandals"}

    sets.idle.Regen = {ammo="Staunch Tathlum",  
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Hermes' Sandals"}

    sets.idle.Weak = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Twilight Mail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Vocane Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}
    
    -- Defense sets
    sets.defense.DT = {ammo="Staunch Tathlum",
        head="Volte Salade",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Flamma Korazin +2",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Vocane Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Volte Brayettes",feet="Flamma Gambieras +2"}

    sets.Kiting = {feet="Hermes' Sandals"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.DT = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonbeam Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    sets.engaged.Acc.DT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Flamma Korazin +2",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Flamma Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}

    -- Dual Wield
    sets.engaged.DW = set_combine(sets.engaged,{
        hands="Emicho Gauntlets +1",
        ear1="Suppanomimi"
    })


    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    --sets.engaged.DW.Melee.MaxHaste
    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
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
    if buffactive['Mighty Strikes'] then
        equip(sets.MightyStrikes)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 12)
    else
        set_macro_page(1, 12)
    end
end
