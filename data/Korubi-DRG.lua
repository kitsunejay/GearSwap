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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'MEVA', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Hasso" <me>')

    select_default_macro_book()
    set_lockstyle(29)

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
    sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail +1"}
    sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +1"}

    sets.precast.JA['Jump'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Telos Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Sulevia's Cuisses +2",feet="Carmine Greaves +1"
    }

    sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Super Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'],{feet="Peltast's Schynbalds +1"}
    sets.precast.JA['Soul Jump'] = sets.precast.JA['Jump']

    sets.precast.JA['Angon'] = {hands="Pteroslaver Finger Gauntlets +1"}
    sets.precast.JA['Spirit Link'] = {head="Vishap Armet +1", hands="Peltast's Vambraces +1"}

    sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +1"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Dagon Breastplate",hands="Sulevia's Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Fotia Belt",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}
    
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    --  73-85% STR / 4hit
    sets.precast.WS['Stardiver'] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Dagon Breastplate",hands="Sulevia's Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Fotia Belt",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"
    }   
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})

    -- 50% STR / Crit / 0.875 attk penalty / 4hit
    sets.precast.WS['Drakesbane'] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Sailfi Belt +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"
    }
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 60% STR / 60% VIT / 3.0 fTP 
    sets.precast.WS["Camlann's Torment"] = {ammo="Knobkierrie",
        head=gear.valorous_head_wsd,neck="Fotia Gorget",ear1="Thrud Earring",ear2="Ishvara Earring",
        body="Dagon Breastplate",hands="Flamma Manopolas +2",ring1="Karieyh Ring +1",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Fotia Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"
    }
    sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 100% STR /  1.0/3.0/5.5 fTP
    sets.precast.WS['Impulse Drive'] = {ammo="Knobkierrie",
        head=gear.valorous_head_wsd,neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Sailfi Belt +1",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"
    }
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    
    -- 40% STR / 40% DEX / 3.0/3.7/4.5
    sets.precast.WS["Sonic Thrust"] = {ammo="Knobkierrie",
        head=gear.valorous_head_wsd,neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Hjarrandi Breastplate",hands="Flamma Manopolas +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Sailfi Belt +1",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"
    }
    sets.precast.WS["Sonic Thrust"].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})


        -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.brigantias_da,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"
    }

    
    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {ammo="Staunch Tathlum +1",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Dagon Breastplate",hands="Sulevia's Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}
    
    sets.idle.Field = {ammo="Staunch Tathlum +1",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.brigantias_da,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.idle.Weak = {ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Twilight Mail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Engulfer Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.defense.Reraise = {ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Twilight Mail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Etiolation Earring",
        body="Tartarus Platemail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Shadow Ring",
        back=gear.brigantias_da,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Sulevia's Leggings +2"}

    sets.Kiting = {feet="Carmine Cuisses +1"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}
    

    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Sherida Earring",ear2="Brutal Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}

    sets.engaged.DT = {ammo="Ginsen",
        head="Hjarrandi Helm",neck="Anu Torque",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Hjarrandi Breastplate",hands="Sulevia's Gauntlets +2",ring1="Moonlight Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}

    sets.engaged.MEVA = {ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",neck="Anu Torque",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands="Sulevia's Gauntlets +2",ring1="Moonlight Ring",ring2="Niqmaddu Ring",
        back=gear.brigantias_da,waist="Ioskeha Belt +1",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}

    sets.engaged.Acc.DT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +2",hands="Otronif Gloves",ring1="Defending Ring",ring2="Flamma Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}

    sets.engaged.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Flamma Ring",
        back="Ik Cape",waist="Goading Belt",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}
    sets.engaged.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Sulevia's Cuisses +2",feet="Flamma Gambieras +2"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
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
        set_macro_page(1, 18)
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
