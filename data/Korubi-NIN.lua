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
    

    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    include('Mote-TreasureHunter')

    state.OffenseMode:options('Normal', 'TH', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.IdleMode:options('Normal', 'Regen')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')
 
    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Danzo Sune-ate"
 
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    set_lockstyle(31)

    select_movement_feet()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')   
    send_command('unbind !-')
    send_command('unbind ^=')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    
    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        waist="Chaac Belt",
        hands=gear.herc_hands_th
    }
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}
 
    sets.precast.Flourish1 = {waist="Chaac Belt"}
 
    -- Fast cast sets for spells
     
    sets.precast.FC = {ammo="Sapience Orb",
        head="Herculean Head",
        body="Dread Jupon",
        hands="Leyline Gloves",
        neck="Baetyl Pendant",
        waist="Ninurta's Sash",
        ear1="Etiolation Earring",
        ear2="Loquac. Earring",
        ring1="Kishar Ring",}
 
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",})
 
    -- Snapshot for ranged
    sets.precast.RA = {legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}}
        
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Seething Bomblet +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}
 
        
    -- Sword
    sets.precast.WS['Savage Blade'] = {ammo="Seething Bomblet +1",
        head="Mpaca's Cap",neck="Republican Platinum Medal",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Regal Ring",
        back="Sacro Mantle",waist="Salifi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS.Acc = sets.precast.FC
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = {ammo="Yetshila +1",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Kendatsuba Hakama +1",
        feet=gear.herc_feet_cchance,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},}
 
    sets.precast.WS['Blade: Hi'] = {ammo="Yetshila +1",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands={ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}},
        legs="Kendatsuba Hakama +1",
        feet="Ryuo Sune-Ate +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},}
 
    sets.precast.WS['Blade: Shun'] = {ammo="Seething Bomblet",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Hizamaru Hizayoroi +2",
        feet="Ken. Sune-ate +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}
 
 
    sets.precast.WS['Aeolian Edge'] = {ammo="Seething Bomblet +1",
        head="Nyame Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Dingir Ring",ring2="Cornelia's Ring",
        back="Sacro Mantle",waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
 
    sets.precast.WS['Evisceration'] = sets.precast.WS['Blade: Jin']

    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.midcast.FastRecast = {}
         
    sets.midcast.Utsusemi = {hands="Mochizuki Tekko",feet="Iga Kyahan +2",back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}}
 
    sets.midcast.ElementalNinjutsu = {ammo="Pemphredo Tathlum",
        head={ name="Herculean Helm", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Crit.hit rate+1','INT+3','Mag. Acc.+7','"Mag.Atk.Bns."+14',}},
        body="Samnuha Coat",
        hands="Mochizuki Tekko",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','AGI+5','"Mag.Atk.Bns."+13',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+2%','"Mag.Atk.Bns."+14',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        ring1="Dingir Ring",
        ring2="Stikini Ring +1",
        back="Izdubar Mantle",}
 
    sets.midcast.ElementalNinjutsu.Resistant = {}
 
    sets.midcast.NinjutsuDebuff = {}
 
    sets.midcast.NinjutsuBuff = {}
 
    sets.midcast.RA = {head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Adhemar Kecks +1",
        feet="Ken. Sune-ate",
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        ear1="Enervating Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},}

 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
     
    -- Resting sets
    sets.resting = {}
     
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet=gear.MovementFeet,
        neck="Loricate Torque +1",
        waist="Flume Belt",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back="Shadow Mantle",}
 
    sets.idle.Town = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Ashera Harness",
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet=gear.MovementFeet,
        neck="Moonbeam Nodowa",
        waist="Flume Belt",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",}
     
    sets.idle.Regen = {head="Rao Kabuto +1",
        body="Hiza. Haramaki +2",
        hands="Rao Kote +1",
        legs="Rao Haidate +1",
        feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",
        waist="Flume Belt",
        ear1="Etiolation Earring",
        ear2="Infused Earring",
        ring1="Paguroidea Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",}

    sets.idle.Town.Regen = {head="Rao Kabuto +1",
        body="Hiza. Haramaki +2",
        hands="Rao Kote +1",
        legs="Rao Haidate +1",
        feet="Rao Sune-Ate +1",
        neck="Sanctity Necklace",
        waist="Flume Belt",
        ear1="Etiolation Earring",
        ear2="Infused Earring",
        ring1="Paguroidea Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",}

     
    -- Defense sets
    sets.defense.Evasion = {}
 
    sets.defense.PDT = {}
 
    sets.defense.MDT = {}
 
 
    sets.Kiting = {feet=gear.MovementFeet}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        --head="Malignance Chapeau",
        head="Adhemar Bonnet +1",
        --body="Adhemar Jacket +1",
        body="Ashera Harness",
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet="Ryuo Sune-ate +1",
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Epona's Ring",
        ring2="Ilabrat Ring",
        back="Sacro Mantle"
    }

    
    sets.engaged.TH = set_combine(sets.engaged, sets.TreasureHunter)
    sets.engaged.Acc = sets.precast.FC
    sets.engaged.Evasion = {}
 
 
    sets.engaged.PDT = {}
 
 
 
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
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

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end
 
function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end
 
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    if state.TreasureMode.value == 'FullTime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet

end
 

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end
 
function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(3, 6)
    else
        set_macro_page(2, 6)
    end
end