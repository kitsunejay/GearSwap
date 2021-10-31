-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')

    include('sammeh_custom_functions.lua')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Mote-TreasureHunter')
    
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')
    
    set_lockstyle(30)


end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal', 'Hybrid', 'Counter')
    state.PhysicalDefenseMode:options('DT')
    state.IdleMode:options('Normal', 'Regen')
    state.WeaponskillMode:options('Normal','Proc')
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        hands=gear.herc_hands_th,
        waist="Chaac Belt", 
    }
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +2"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +2"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +2"}
    sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters +1"}
    sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +1"}
    sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

    sets.precast.JA['Chi Blast'] = {head="Hesychast's Crown +2",}

    sets.precast.JA['Chakra'] = {
        head="Rao Kabuto +1",ear1="Thureous Earring",ear2="Odnowa Earring +1",
        body="Anchorite's Cyclas +2",hands="Hesychast's Gloves +1",ring1="Niqmaddu Ring",ring2="Regal Ring",
        Legs="Hizamaru Hizayoroi +2",feet="Hesychast's Gaiters +1"
    }

 
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb", 
        head="Herculean Helm",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquac. Earring",
        body="Adhemar Jacket",hands="Leyline Gloves",
    }
    
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Hesychast's Crown +2",neck="Anu Torque",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Anchorite's Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +2",feet=gear.herc_feet_ta 
    }

    sets.precast.MaxTP = {ear1="Telos Earring"}
    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.
    -- STR 30% DEX 30%
    sets.precast.WS["Raging Fists"] = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Anu Torque",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-ate +1"
    }

    -- STR 20% VIT 50%
    sets.precast.WS["Howling Fist"] = {ammo="Knobkierrie",
        head="Hesychast's Crown +2",neck="Anu Torque",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Anchorite's Gloves +2",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.segomo_wsd,waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +2",feet=gear.herc_feet_ta 
    }
    
    -- STR 50% VIT 50%
    sets.precast.WS["Dragon Kick"] = set_combine(sets.precast.WS["Howling Fist"],{feet="Anchorite's Gaiters +2"})

    -- STR 40% VIT 40%
    sets.precast.WS["Tornado Kick"] = sets.precast.WS["Dragon Kick"]

    -- STR 50% VIT 50% / Crit
    sets.precast.WS["Ascetic's Fury"]  = {ammo="Knobkierrie",
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +2",feet=gear.herc_feet_ta 
    }
        
    -- STR 80% / Crit
    sets.precast.WS["Victory Smite"] = {ammo="Knobkierrie",
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Kendatsuba Hakama +1",feet=gear.herc_feet_cdmg
    }

    -- DEX 73% ~ 85% 
    sets.precast.WS["Shijin Spiral"] = {ammo="Knobkierrie",
        head="Hesychast's Crown +2",neck="Anu Torque",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.segomo_dexda,waist="Windbuffet Belt +1",legs="Hizamaru Hizayoroi +2",feet=gear.herc_feet_ta 
    }
    -- Sets to return to when not performing an action.
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Hermes' Sandals"
    }

    sets.idle.Town = {ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",neck="Loricate Torque +1",ear1="Odr Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.segomo_da,waist="Windbuffet Belt +1",legs="Kendatsuba Hakama +1",feet="Hermes' Sandals"
    }
    
    sets.idle.Weak = {}

    sets.idle.Regen = {ammo="Staunch Tathlum +1",head="Rao Kabuto +1",body="Hizamaru Haramaki +2",hands="Rao Kote +1",legs="Rao Haidate +1",feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",waist="Windbuffet Belt +1",ear1="Etiolation Earring",ear2="Infused Earring",
        ring1="Paguroidea Ring",ring2="Chirich Ring +1",back=gear.segomo_da,}
    
    -- Defense sets
    sets.defense.DT = {ammo="Staunch Tathlum +1",head="Adhemar Bonnet +1",body="Mummu Jacket +2",hands="Adhemar Wristbands +1",legs="Mummu Kecks +2",
        feet="Hermes' Sandals",neck="Loricate Torque +1",waist="Windbuffet Belt +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        ring1="Defending Ring",ring2="Chirich Ring +1",back=gear.segomo_da,}

    sets.Kiting = {feet="Hermes' Sandals"}


    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Adhemar Wristbands +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
        back=gear.segomo_tp,waist="Windbuffet Belt +1",legs="Kendatsuba Hakama +1",feet=gear.herc_feet_ta}

    sets.engaged.Acc = {ammo="Amar Cluster",
        head="Kendatsuba Jinpachi +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",
        back=gear.segomo_tp,waist="Windbuffet Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-Ate +1"
    }
    
    -- Defensive melee hybrid sets
    sets.engaged.Hybrid = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Ashera Harness",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gere Ring",
        back=gear.segomo_tp,waist="Windbuffet Belt +1",legs="Malignance Tights",feet=gear.herc_feet_ta
    }
    sets.engaged.Counter = {ammo="Amar Cluster",
        head="Rao Kabuto +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
        body="Hesychast's Cyclas +3",hands="Rao Kote +1",ring1="Niqmaddu Ring",ring2="Epona's Ring",
        back=gear.segomo_tp,waist="Windbuffet Belt +1",legs="Anchorite's Hose +2",feet="Hesychast's Gaiters +3"
    }
    sets.engaged.Acc.Counter = sets.engaged.Counter
    


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})


    -- Footwork combat form
    sets.engaged.Footwork = set_combine(sets.engaged, {feet="Anchorite's Gaiters +2"})
    sets.engaged.Footwork.Impetus = set_combine(sets.engaged.Footwork, {body="Bhikku Cyclas +1"})
    sets.engaged.Footwork.Acc = set_combine(sets.engaged.Acc, {feet="Anchorite's Gaiters +2"})
    sets.engaged.Footwork.Acc.Impetus = set_combine(sets.engaged.Footwork.Acc, {body="Bhikku Cyclas +1"})

    sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {feet="Anchorite's Gaiters +2"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            equip(sets.impetus_body)
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['Hundred Fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['Hundred Fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

function job_status_change(stateField, newValue, oldValue)
    update_melee_groups()
    handle_equipping_gear(player.status)
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['Hundred Fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['Hundred Fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end