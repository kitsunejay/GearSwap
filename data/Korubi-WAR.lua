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

    include('Mote-TreasureHunter')
    include('sammeh_custom_functions.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDL', 'SubtleBlow')
    state.HybridMode:options('Normal', 'DT', 'MEVA', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL', 'Proc')
    state.PhysicalDefenseMode:options('Turtle', 'Reraise')
    state.IdleMode:options('Normal', 'DT', 'Turtle', 'Regen', 'Regain')

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
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +3",body="Pummeler's Lorica +3",back=gear.cichol_tp}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +3"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}
    sets.precast.JA['Defender'] = {hands="Agoge Mufflers"}
    sets.precast.JA['Retaliation'] = {feet="Boii Calligae +2"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica +2"}
    sets.precast.JA['Tomahawk'] = {ammo="Throwing Tomahawk"}

    --Will be added ontop of chosen set
    sets.MightyStrikes = {
        ammo="Yetshila +1",
        feet="Boii Calligae +2"
    }
    
    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        waist="Chaac Belt"
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nyame Mail",hands="Boii Mufflers +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Greatsword
    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet +1",
        head="Hjarrandi Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Boii Earring +1",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws_da,waist="Fotia Belt",legs="Boii Cuisses +2",feet="Pummeler's Calligae +3"}
    sets.precast.WS['Resolution'].PDL = {ammo="Seething Bomblet +1",
        head="Sakpata's Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Boii Earring +1",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws_da,waist="Fotia Belt",legs="Boii Cuisses +2",feet="Sakpata's Leggins"}

    -- Great Axe
    sets.precast.WS['Upheaval'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nyame Mail",hands="Boii Mufflers +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    sets.precast.WS['Upheaval'].PDL = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Nyame Mail",hands="Boii Mufflers +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Boii Cuisses +2",feet="Nyame Sollerets"}

    sets.precast.WS["Ukko's Fury"] = {ammo="Yetshila +1",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Boii Earring +1",
        body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Boii Calligae +2"}
    
    sets.precast.WS["Impulse Drive"] = {ammo="Yetshila +1",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Boii Earring +1",
        body="Hjarrandi Breastplate",hands="Boii Mufflers +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Boii Cuisses +2",feet="Boii Calligae +2"}

    sets.precast.WS["King's Justice"] = sets.precast.WS['Upheaval'] 
    sets.precast.WS["King's Justice"].PDL = sets.precast.WS['Upheaval'].PDL

    sets.precast.WS["Armor Break"] = {ammo="Pemphredo Tathlum",
        head="Boii Mask +2",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Crepuscular Earring",
        body="Boii Lorica +2",hands="Boii Mufflers +2",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back=gear.cichol_wsd,waist="Eschan Stone",legs="Boii Cuisses +2",feet="Boii Calligae +2"}

    sets.precast.WS["Full Break"] = sets.precast.WS["Armor Break"]

    -- Sword
    sets.precast.WS['Savage Blade'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Pummeler's Lorica +3",hands="Boii Mufflers +2",ring1="Cornelia's Ring",ring2="Regal Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Sulevia's Leggings +2"}
    sets.precast.WS['Savage Blade'].PDL = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Pummeler's Lorica +3",hands="Boii Mufflers +2",ring1="Cornelia's Ring",ring2="Regal Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Boii Cuisses +2",feet="Sulevia's Leggings +2"}

    -- Axe
    sets.precast.WS['Decimation'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Boii Cuisses +2",feet="Flamma Gambieras +2"}

    -- mistral axe
    -- cloud splitter

    -- Club
    sets.precast.WS['Judgement'] = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Pummeler's Lorica +3",hands="Boii Mufflers +2",ring1="Cornelia's Ring",ring2="Regal Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Sulevia's Leggings +2"}
    sets.precast.WS['Judgement'].PDL = {ammo="Knobkierrie",
        head="Agoge Mask +3",neck="Warrior's Bead Necklace +2",ear1="Moonshade Earring",ear2="Thrud Earring",
        body="Pummeler's Lorica +3",hands="Boii Mufflers +2",ring1="Cornelia's Ring",ring2="Regal Ring",
        back=gear.cichol_wsd,waist="Sailfi Belt +1",legs="Boii Cuisses +2",feet="Sulevia's Leggings +2"}
    
    -- Staff

    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle.Town = {ammo="Ginsen",     
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Dagon Breastplate",hands="Sakpata's Gauntlets",ring1="Shneddick Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_wsd,waist="Ioskeha Belt +1",legs="Volte Brayettes",feet="Sakpata's Leggings"}
    
    sets.idle.Field = {ammo="Staunch Tathlum +1",  
        head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Alabaster Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Shneddick Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

    sets.idle.Regen = {ammo="Staunch Tathlum +1",  
        head="Volte Salade",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Genmei Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Shneddick Ring",ring2="Chirich Ring +1",
        back=gear.cichol_tp,waist="Flume Belt",legs="Volte Brayettes",feet="Pummeler's Calligae +3"}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Shneddick Ring",ring2="Gelatinous Ring +1",
        back=gear.cichol_tp,waist="Flume Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
    
    -- Defense sets
    sets.defense.Turtle = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Murky Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
    sets.defense.MDT = sets.defense.Turtle

    sets.Kiting = {ring1="Shneddick Ring"}

    sets.Reraise = {head="Crepuscular Helm",body="Twilight Mail"}

    sets.precast.MaxTP = {ear2="Ishvara Earring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Two handed
    sets.engaged = {ammo="Ginsen",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Boii Lorica +2",hands="Sakpata's Gauntlets",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Sailfi Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.engaged.Acc = {ammo="Ginsen",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Boii Lorica +2",hands="Sakpata's Gauntlets",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.engaged.DT = {ammo="Ginsen",
        head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Chirich Ring +1",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Sailfi Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

    sets.engaged.SubtleBlow = {ammo="Ginsen",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Dagon Breastplate",hands="Sakpata's Gauntlets",ring1="Chirich Ring +1",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Sailfi Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}   

     -- Single wield
    sets.engaged.SW = {ammo="Ginsen",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Schere Earring",ear2="Boii Earring +1",
        body="Hjarrandi Breastplate",hands="Sakpata's Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Sailfi Belt +1",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    -- Dual Wield
    sets.engaged.DW = {ammo="Ginsen",
        head="Boii Mask +2",neck="Warrior's Bead Necklace +2",ear1="Eabani Earring",ear2="Boii Earring +1",
        body="Agogee Lorica +3",hands="Sakpata's Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Reiki Yotai",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell)
    checkblocking(spell)
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
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    --add_to_chat(123, player.equipment.sub)
    if player.equipment.sub == 'empty' then
        state.CombatForm:set('SW')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
        return
    else
        -- Single Wield
        for key, value in ipairs({'shield','bulwark','forfend'}) do
            if string.find(player.equipment.sub:lower(), value) then
                state.CombatForm:set('SW')
                if not midaction() then
                    handle_equipping_gear(player.status)
                end
                return
            end
        end
        -- Two handed 
        for key, value in ipairs({'strap','grip'}) do
            if string.find(player.equipment.sub:lower(), value) then
                state.CombatForm:set('')
                if not midaction() then
                    handle_equipping_gear(player.status)
                end
                return
            end
        end
        -- Dual wield
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            state.CombatForm:set('DW')
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
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
