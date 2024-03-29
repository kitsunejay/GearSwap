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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Melee','Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('DT', 'Normal')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
   
    update_defense_mode()

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Reverence Coronet +1",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",ring1="Leviathan Ring",ring2="Aquasoul Ring",
        back="Weard Mantle",legs="Souveran Diechlings +1",feet="Sulevia's Leggings +2"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Reverence Coronet +1",
        body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Souveran Diechlings +1",feet="Sulevia's Leggings +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps 80%; PLD JT: 0%
    sets.precast.FC = {
        ammo="Sapience Orb",		    --2%
        neck="Baetyl Pendant",
        ear1="Loquacious Earring",      --2%
        ear2="Etiolation Earring",      --1%
		body="Reverence Surcoat +2",    --5%
		hands="Leyline Gloves",		    --8%
		waist="Ninurta's Sash", 
		feet="Carmine Greaves +1"	    --8%
    }
    
    sets.precast.FC.DT = {
        ammo="Sapience Orb",		    --2%
        neck="Loricate Torque +1",
        ear1="Loquacious Earring",      --2%
        ear2="Etiolation Earring",      --1%
		body="Reverence Surcoat +2",    --5%
		hands="Leyline Gloves",		    --8%
		waist="Ninurta's Sash", 
		feet="Carmine Greaves +1"	    --8%
	}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    --sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Enhancing Magic'].DT = {waist="Siegel Sash"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		neck="Diemer Gorget",
	})

	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Gorney Haubert +1",hands="Cizin Mufflers",ring1="Sulevia's Ring",ring2="Cho'j Band",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}

    sets.precast.WS.Acc = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Gorney Haubert +1",hands="Buremte Gloves",ring1="Sulevia's Ring",ring2="Patricius Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring",ring2="Aquasoul Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Buremte Gloves",waist="Zoran's Belt"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Zoran's Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",ring1="Metamorph Ring +1",ring2="Gelatinous Ring +1",
        back="Toro Cape",waist="Caudata Belt",legs="Souveran Diechlings +1",feet="Reverence Leggings +1"}
    
    sets.precast.WS['Atonement'] = {ammo="Homiliary",
        head="Sulevia's Mask +2",neck="Fotia Gorget",ear1="Creed Earring",ear2="Steelflash Earring",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",ring1="Sulevia's Ring",ring2="Vexer Ring",
        back="Fierabras's Mantle",waist=gear.ElementalBelt,legs="Souveran Diechlings +1",feet="Caballarius Leggings"}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Reverence Coronet +1",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",
        waist="Zoran's Belt",legs="Enif Cosciales",feet="Reverence Leggings +1"}
        
    sets.midcast.Enmity = {ammo="Staunch Tathlum +1",
        head="Souveran Schaller +1",neck="Loricate Torque +1",
        body="Souveran Cuirass +1",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Creed Baudrier",legs="Souveran Diechlings +1",feet="Souveran Schuhs +1"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales"})
    
    sets.midcast.Stun = sets.midcast.Flash



    sets.midcast.Cure = {ammo="Homiliary",
        head="Souveran Schaller +1",neck="Diemer Gorget",ear1="Nourishing Earring +1",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Creed Baudrier",legs="Souveran Diechlings +1",feet="Souveran Schuhs +1"
    }

    sets.midcast.Cure.DT = {
        head="Souveran Schuh",ear1="Nourishing Earring +1",ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Creed Baudrier",legs="Souveran Diechlings +1",feet="Souveran Schuhs +1"
    }

    sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Reverence Breeches +1"}
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
        back="Weard Mantle",feet="Souveran Schuhs +1"})

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {ammo="Homiliary",
        head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Souveran Schuhs +1"}

    sets.idle.Town = {main="Anahera Sword",ammo="Sapience Orb",
        head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Odnowa Earring +1",
        body="Souveran Cuirass +1",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Souveran Schuhs +1"}
    
    sets.idle.Weak = {ammo="Homiliary",
        head="Souveran Schaller +1",neck="Creed Collar",ear1="Thureous Earring",ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Weard Mantle",waist="Flume Belt",legs="Sulevia's Cuisses +2",feet="Sulevia's Leggings +2"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Nixxer",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Nixxer",sub="Beatific Shield +1"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {ammo="Homiliary",
        head="Souveran Schaller +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Buckler Earring",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Souveran Diechlings +1",feet="Souveran Schuhs +1"}
    sets.defense.HP = {ammo="Homiliary",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Gelatinous Ring +1",ring2="Gelatinous Ring +1",
        back="Weard Mantle",waist="Creed Baudrier",legs="Souveran Diechlings +1",feet="Reverence Leggings +1"}
    sets.defense.Reraise = {ammo="Homiliary",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Twilight Mail",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Weard Mantle",waist="Nierenschutz",legs="Souveran Diechlings +1",feet="Reverence Leggings +1"}
    sets.defense.Charm = {ammo="Homiliary",
        head="Sulevia's Mask +2",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Souveran Diechlings +1",feet="Reverence Leggings +1"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Demonry Stone",
        head="Sulevia's Mask +2",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +2",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Creed Baudrier",legs="Osmium Cuisses",feet="Reverence Leggings +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Ginsen",
        head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Reverence Surcoat +2",hands="Souveran Handschuhs +1",ring1="Sulevia's Ring",ring2="Gelatinous Ring +1",
        back=gear.rudianos_enmity,waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Souveran Schuhs +1"}
    
    sets.engaged.Melee = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Telos Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Sulevia's Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.engaged.Acc = {ammo="Ginsen",
        head="Souveran Schaller +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Gorney Haubert +1",hands="Souveran Handschuhs +1",ring1="Sulevia's Ring",ring2="Gelatinous Ring +1",
        back="Weard Mantle",waist="Zoran's Belt",legs="Sulevia's Cuisses +2",feet="Souveran Schuhs +1"}

    sets.engaged.DW = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Flamma Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Flamma Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.engaged.DW.HighHaste = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Flamma Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}
        
    sets.engaged.DW.MidHaste = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Flamma Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.engaged.DW.LowHaste = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Valorous Mail",hands="Sakpata 's Gauntlets",ring1="Flamma Ring",ring2="Gelatinous Ring +1",
        back="Atheling Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Sulevia's Mask +2",neck="Sanctity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Gorney Haubert +1",hands="Buremte Gloves",ring1="Sulevia's Ring",ring2="Gelatinous Ring +1",
        back="Weard Mantle",waist="Zoran's Belt",legs="Sulevia's Cuisses +2",feet="Souveran Schuhs +1"}

    sets.engaged.PDT = set_combine(sets.engaged, {body="Reverence Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Reverence Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Reverence Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Reverence Surcoat +2",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	--sets.Reive.Cure.with_buff['reive mark'] = {neck="Arciela's Grace +1"}

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end

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

    msg = msg .. ': Casting ['..state.CastingMode.value..'], Idle ['..state.IdleMode.value..']'

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    if haste_string then
        msg = msg .. ' '..haste_string
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
        set_macro_page(4, 2)
    elseif player.sub_job == 'NIN' then
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(2, 2)
    end
end