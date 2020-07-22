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
    state.HybridMode:options('Normal', 'DT', 'MEVA','Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('DT', 'Reraise')
    state.MagicalDefenseMode:options('MDT', 'MEVA', 'Reraise')
    state.IdleMode:options('Normal', 'DT','Regen')

    pick_tp_weapon()
    update_combat_form()

    -- Additional local binds
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind !` input /ja "Hasso" <me>')

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
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +2",body="Pummeler's Lorica +3",back=gear.cichol_tp}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}

    sets.precast.JA['Retaliation'] = {feet="Boii Calligae +1"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica"}
    sets.precast.JA['Tomahawk'] = {ammo="Throwing Tomahawk"}

    sets.precast.FC['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_stp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    sets.midcast['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_stp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
         
    -- Misc
    sets.Hybrid = {
        head="Volte Salade",
        body="Tartarus Platemail",
        legs="Volte Brayettes"
    }

    sets.MightyStrikes = {
        ammo="Yetshila +1",
        feet="Boii Calligae +1"
    }
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Pummeler's Lorica +3",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Greatsword

    --  40% STR / 40% VIT
    sets.precast.WS['Scourge'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Pummeler's Lorica +3",hands="Sulevia's Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Sulevia's Leggings +2"}

    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Flamma Gambieras +2"}

    sets.precast.WS['Resolution'].Acc = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    -- Great Axe
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        head="Agoge Mask +3",
        body="Pummeler's Lorica +3",hands=gear.odyssean_hands_wsd,
        back=gear.cichol_upheaval,waist="Ioskeha Belt +1",feet="Sulevia's Leggings +2"})  
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {        
        head="Agoge Mask +3",
        body="Pummeler's Lorica +3",hands=gear.odyssean_hands_wsd,
        back=gear.cichol_upheaval,waist="Ioskeha Belt +1",feet="Sulevia's Leggings +2"})

    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        body="Hjarrandi Breastplate",
        hands="Flamma Manopolas +2",
        feet="Boii Calligae +1"})
        
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {        
        ammo="Yetshila +1",
        hands="Flamma Manopolas +2"})
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

    sets.precast.WS["Armor Break"] = {ammo="Pemphredo Tathlum",
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Dignitary's Earring",
        body="Flamma Korazin +2",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Stikini Ring +1",
        back=gear.cichol_ws,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flamma Gambieras +2"}

    sets.precast.WS["Full Break"] = sets.precast.WS["Armor Break"]

    sets.precast.MaxTP = {ear2="Ishvara Earring"}

    -- Sword
    sets.precast.WS['Savage Blade'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Pummeler's Lorica +3",hands="Sulevia's Gauntlets +2",ring1="Karieyh Ring +1",ring2="Regal Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Sulevia's Leggings +2"}

    -- Axe

    sets.precast.WS['Decimation'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Telos Earring",
        body="Argosy Hauberk +1",hands="Argosy Mufflers +1",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Argosy Breeches +1",feet="Flamma Gambieras +2"}

    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle.Town = {ammo="Ginsen",     
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Thrud Earring",ear2="Cessance Earring",
        body="Argosy Hauberk +1",hands="Sulevia's Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Volte Brayettes",feet="Hermes' Sandals"}
    
    sets.idle.Field = {ammo="Staunch Tathlum +1",  
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}

    sets.idle.Regen = {ammo="Staunch Tathlum +1",  
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Genmei Earring",
        body=gear.valorous_body_stp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Tartarus Platemail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}
    
    -- Defense sets
    sets.defense.DT = {ammo="Staunch Tathlum +1",
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Flamma Gambieras +2"}
    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Tartarus Platemail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Flamma Gambieras +2"}

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
        body=gear.valorous_body_da,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.Chango = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_da,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_da,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.engaged.DT = {ammo="Ginsen",
        head="Hjarrandi Helm",neck="Warrior's Bead Necklace +2",ear1="Telos Earring",ear2="Cessance Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Moonbeam Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    sets.engaged.MEVA = {ammo="Ginsen",
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Telos Earring",ear2="Cessance Earring",
        body="Tartarus Platemail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}

    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.Hybrid)

    -- Dual Wield
    sets.engaged.DW = set_combine(sets.engaged,{
        hands="Emicho Gauntlets +1",
        ear1="Suppanomimi"
    })

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.Hybrid)
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.Hybrid)

    --sets.engaged.DW.Melee.MaxHaste
    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.Hybrid)
    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.Hybrid)
    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.Hybrid)

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    pick_tp_weapon()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not S{'strap','grip'}:contains(player.equipment.sub:lower()) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
    if not midaction() then
		handle_equipping_gear(player.status)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
        if buffactive['Mighty Strikes'] then
            equip(sets.MightyStrikes)
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
    pick_tp_weapon()
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if player.equipment.main == 'Chango' then
        state.CombatWeapon:set('Chango')
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()

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
