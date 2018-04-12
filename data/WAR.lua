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
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
        
	-- Ambuscade Capes
    gear.cichol_ws 	={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
    gear.cichol_tp  ={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
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
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae",body="Pummeler's Lorica"}
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica"}
    sets.precast.JA['Warcry'] = {head="Agoge Mask"}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}

    sets.precast.JA['Retaliation'] = {feet="Boii Calligae"}
    sets.precast.JA['Blood Rage'] = {body="Boii Lorica"}

    sets.precast.FC['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    sets.midcast['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Flamma Zucchetto +2",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Valorous Hose",feet="Otronif Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Scourge'] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Flamma Korazin +1",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"
    }

    sets.precast.WS['Resolution'] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"
    }
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    sets.precast.WS['Resolution'].Mod = set_combine(sets.precast.WS['Resolution'], {waist="Fotia Belt"})

    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    sets.precast.WS['Upheaval'].Mod = set_combine(sets.precast.WS['Upheaval'], {waist="Fotia Belt"})

    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS["Ukko's Fury"].Mod = set_combine(sets.precast.WS["Ukko's Fury"], {waist="Fotia Belt"})

    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})

        -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Flamma Zucchetto +2",
        body="Otronif Harness +1",hands="Otronif Gloves",
        legs="Arjuna Breeches",feet="Otronif Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {      
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Argosy Hauberk",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Warp Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Hermes' Sandals"}
    
    sets.idle.Field = {
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Hermes' Sandals"}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Twilight Mail",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Vocane Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +2"}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +2"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +2"}

    sets.Kiting = {feet="Hermes' Sandals"}

    --sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Flamma Korazin +1",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body=gear.valorous_body_tp,hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Flamma Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Pummeler's Calligae +3"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Flamma Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Flamma Ring",
        back="Ik Cape",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    
    --[[
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Wakido Kote +2",ring1="Petrov Ring",ring2="Flamma Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Adoulin.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Adoulin.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Hizamaru Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Adoulin.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Ik Cape",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Pummeler's Cuisses +3",feet="Flamma Gambieras +2"}
    ]]--
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
