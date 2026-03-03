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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    select_default_macro_book()
	
    set_lockstyle(1)

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Organizer items

    organizer_items = {
        echos="Echo Drops",
        shihei="Shihei",
        remedy="Remedy"
    }
    -- Precast Sets

    -- Fast cast sets for spells

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	    -- Fast Cast caps 80%; WHM JT: 0% /SCH LA 10%
        --      46/ 80%
    sets.precast.FC = {
        ammo="Sapience Orb",                --2%
        --head="Cath Palug Crown",            --8%    
        head=gear.vanya_head_fc,
        neck="Baetyl Pendant",              --4%
        --ear1="Etiolation Earring",          --1%
        ear1="Loquacious Earring",          --1%
        ear2="Malignance Earring",          --2%
        body="Inyanga Jubbah +2",           --14%
        --hands="Fanatic Gloves",             --7%
        hands="Gendewitha Gages +1",        --7%
        ring1="Murky Ring",
        ring2="Kishar Ring",                --5%
        back="Alaunus's Cape",              --10%
        waist="Witful Belt",
        --legs="Kaykaus Tights +1",           --7%
        legs="Ayanmo Cosciales +2",         --6%
        feet="Regal Pumps +1"               --5-7%
    }
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	    -- Fast Cast caps 80%; WHM JT: 0% /SCH LA 10%
        --      69/ 80% CCT+FC 
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        main="Queller Rod",             --7%
        sub="Sors Shield",
        ear1="Mendicant's Earring",     --4%
        ear2="Nourishing Earring +1",   --5%
        legs="Ebers Pantaloons +1",     --13%
    })
  
	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliaut"}
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        head="Nyame Helm",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Moonshade Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist="Fotia Belt",legs="Ayanmo Cosciales +2",feet="Nyame Sollerets"}
    
    sets.precast.WS['Flash Nova'] = {range="Pemphredo Tathlum",
        head="Cath Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Malignance Earring",
        body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back="Toro Cape",waist="Sacro Cord",legs="Ayanmo Cosciales +2",feet=gear.chironic_feet_refresh}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Vanya Hood",ear1="Etiolation Earring",ear2="Malignance Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",
        back="Alaunus's Cape",waist="Shinjutsu-no-obi +1",
        --legs=gear.telchine_legs_enh_dur,
        feet="Regal Pumps +1"}
    
    sets.midcast.Warp = sets.midcast.FastRecast
    sets.midcast['Warp II'] = sets.midcast.FastRecast
    
    -- Cure sets
        -- Maximum 50% Cure Potency
        -- Maximum 30% Cure Potency II
        -- Maximum -50 Enmity


    -- 41/50% CP, 2/30% CP2   |   -19/50 Enmity   |   Skill 0/500
    sets.midcast.Cure = {
        main="Queller Rod",                 
        --main="Raetic Rod +1",                 
        --sub="Genbu's Shield",
        sub="Sors Shield",
        ammo="Pemphredo Tathlum",
        --head="Kaykaus Mitra +1",            --13% CP
        head=gear.vanya_head_skill,
        neck="Cleric's Torque",             --5%  CP
        ear1="Mendicant's Earring",
        ear2="Glorious Earring",            --2 CP2
        body="Theophany Bliaut +4",         --6 CP2
        hands="Theophany Mitts +3",         -- -4 enmity
        --hands="Kaykaus Cuffs +1",           --10% CP   , -4 enmity
        --hands="Inyanga Dastanas +2",
		ring1="Sirona's Ring",             
		ring2="Lebeche Ring",
        back="Alaunus's Cape",
        waist="Shinjutsu-no-obi +1",
        legs="Ebers Pantaloons +1",
        --feet="Kaykaus Boots +1"              -- 7% CP
        feet=gear.vanya_feet_cp 	
    }

    sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{
        body="Ebers Bliaut +1",
        back="Alaunus's Cape"
    })

    sets.midcast.Curaga = sets.midcast.Cure

    -- Post midcast sets, no need to combine
    sets.midcast.CureSelf = {waist="Gishdubar Sash"}

    sets.midcast.CureWeather = {
        main="Chatoyant Staff",         --10% CP
        sub="Enki Strap",
        waist="Korin Obi",}

    sets.midcast.CuragaWeather = {
        main="Chatoyant Staff",         --10% CP
        sub="Enki Strap",
        waist="Korin Obi",
        back="Twilight Cape"}   

    sets.midcast.Cursna = {main="Gada",sub="Genbu's Shield",
        head="Vanya Hood",neck="Incanter's Torque",
        body="Ebers Bliaut +1",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Menelaus's Ring",
        back="Alaunus's Cape",waist="Bishop's Sash",legs="Theophany Pantaloons +4",feet="Vanya Clogs"}

    sets.midcast.StatusRemoval = {
        head="Ebers Cap +1",legs="Ebers Pantaloons +1"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
        head="Befouled Crown",neck="Incanter's Torque",
        body=gear.telchine_body_enh_dur,hands="Inyanga Dastanas +2",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +2",feet="Ebers Duckbills +1"}

    sets.midcast.Erase = set_combine(sets.midcast.FastRecast,{neck="Cleric's Torque"})

    sets.midcast.Stoneskin = {
        head="Vanya Hood",neck="Nodens Gorget",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",
        back="Swith Cape +1",waist="Siegel Sash"}

    sets.midcast.Auspice = {hands="Inyanga Dastanas +2",feet="Ebers Duckbills +1"}

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
        main="Beneficus",sub="Ammurapi Shield",
        head="Ebers Cap +1",neck="Incanter's Torque",
        body="Ebers Bliaut +1",hands="Ebers Mitts +1",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +2",feet="Ebers Duckbills +1"})

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --10%
        body=gear.telchine_body_enh_dur,    --10%
        hands=gear.telchine_hands_enh_dur,  --10%
        waist="Embla Sash",                 --10%
        legs=gear.telchine_legs_enh_dur,    --10%
        feet="Theophany Duckbills +3"       --10%
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration,{
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Inyanga Tiara +2",
        body="Piety Bliaut",
        hands="Ebers Mitts +1",
        legs="Theophany Pantaloons +4"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration,{hands="Inyanga Dastanas +2",feet="Ebers Duckbills +1"})

    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration

    sets.midcast.Shellra = sets.midcast.EnhancingDuration
    sets.midcast.Protectra = sets.midcast.EnhancingDuration

    sets.midcast['Divine Magic'] = {main="Queller Rod",sub="Genbu's Shield",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Crepuscular Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Stikini Ring +1",ring2="Stikini Ring",
        back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons +4",feet="Vanya Clogs"}

    sets.midcast['Dark Magic'] = {main="Queller Rod", sub="Genbu's Shield",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Crepuscular Earring",
        body="Shango Robe",hands="Inyanga Dastanas +2",ring1="Stikini Ring +1",ring2="Stikini Ring",
        back="Refraction Cape",waist="Luminary Sash",legs=gear.chironic_pants_macc,feet="Nyame Sollerets"}

    -- Custom spell classes
    sets.midcast['Enfeebling Magic'] = {main="Gada", sub="Ammurapi Shield",ammo="Hydrocera",
        head="Theophany Cap +2",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Malignance Earring",
        body="Theophany Bliaut +4",hands="Theophany Mitts +3",ring1="Stikini Ring +1",ring2="Stikini Ring",
        back="Alaunus's Cape",waist="Luminary Sash",legs="Theophany Pantaloons +4",feet="Theophany Duckbills +3"}

    -- Cant be resisted so add TH
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], {
        waist="Chaac Belt"
    })
    sets.midcast.Dia = sets.midcast.Diaga
    sets.midcast['Repose'] = sets.midcast['Enfeebling Magic']
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = sets.idle

    -- Idle sets
    sets.idle = { main="Bolelabunga", sub="Archduke's Shield",
        head="Inyanga Tiara +2",neck="Sanctity Necklace",ear1="Alabaster Earring",ear2="Eabani Earring",
        body="Theophany Bliaut +4",hands="Inyanga Dastanas +2",ring1="Murky Ring",ring2="Shneddick Ring",
        back="Alaunus's Cape",waist="Embla Sash",legs="Theophany Pantaloons +4",feet="Inyanga Crackows +2"
    }

    sets.idle.DT = {main="Bolelabunga", sub="Genbu's Shield",ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",neck="Warder's Charm +1",ear1="Alabaster Earring",ear2="Eabani Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Murky Ring",ring2="Defending Ring",
        back="Alaunus's Cape",waist="Eschan Stone",legs="Theophany Pantaloons +4",feet=gear.chironic_feet_refresh}

    sets.idle.Town = { main="Queller Rod", sub="Archduke's Shield",
        head="Inyanga Tiara +2",neck="Cleric's Torque",ear1="Alabaster Earring",ear2="Eabani Earring",
        body="Theophany Bliaut +4",hands="Theophany Mitts +3",ring1="Murky Ring",ring2="Shneddick Ring",
        back="Alaunus's Cape",waist="Embla Sash",legs="Theophany Pantaloons +4",feet="Theophany Duckbills +3"
    }
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Ebers Bliaut +1",hands=gear.chironic_hands_refresh,ring1="Murky Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",waist="Witful Belt",legs="Theophany Pantaloons +4",feet=gear.chironic_feet_refresh}
    
    -- Defense sets

    sets.defense.PDT = {main="Daybreak", sub="Genbu's Shield",ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Murky Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",legs="Ayanmo Cosciales +2",feet=gear.chironic_feet_refresh}

    sets.defense.MDT = {main="Daybreak", sub="Genbu's Shield",ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Murky Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",legs="Ayanmo Cosciales +2",feet=gear.chironic_feet_refresh}

    sets.Kiting = {ring2="Shneddick Ring"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = { main="Queller Rod", sub="Archduke's Shield",
        head="Ayanmo Zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Eabani Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Alaunus's Cape",waist="Cetl Belt",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"
    }
    
    sets.engaged.DW = {
        head="Ayanmo Zucchetto +2",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Beeline Ring",ring2="Apate Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
    

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end

    -- Weather checks
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.skill == "Elemental Magic" then
                equip(set_combine(sets.midcast['Elemental Magic'], {waist="Korin Obi",}))
                if _settings.debug_mode then
                    add_to_chat(123,'--- Equiping obi for Elemental ---')
                end
            elseif spellMap == "Cure" or spellMap == "CureSolace" or spellMap == "CureMisery" then
                if spell.target.type == 'SELF' then
                    equip(set_combine(sets.midcast.CureSelf,sets.midcast.CureWeather))
                    if _settings.debug_mode then
                        add_to_chat(123,'--- Equiping obi for CureSelf w/ Weather ---')
                    end
                else
                    equip(sets.midcast.CureWeather)
                    if _settings.debug_mode then
                        add_to_chat(123,'--- Equiping obi for Cure w/ Weather---')
                    end
                end
            elseif spellMap == "Curaga" then
                equip(sets.midcast.CuragaWeather)
                if _settings.debug_mode then
                    add_to_chat(123,'--- Equiping obi for Curaga w/ Weather---')
                end
            end
        end
    end
end

  
function job_post_aftercast(spell, action, spellMap, eventArgs)
    --local spell_recasts = windower.ffxi.get_spell_recasts()
    
    --add_to_chat(213,spell.english..' > '..spell_recasts[spell.recast_id]) 
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.equipment.sub and not player.equipment.sub:contains('Shield') then
                state.CombatForm:set('DW')
            else
                state.CombatForm:reset()
            end
        end    
    end
end

function job_pretarget(spell)
    checkblocking(spell)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == 'Enhancing Magic' then
            if S{'Refresh'}:contains(default_spell_map) then
                if spell.target.type == 'SELF' then
                    if _settings.debug_mode then
                        add_to_chat(123,'--- RefreshSelf ---')
                    end
                    return "RefreshSelf"
                end
            elseif not S{'Erase','Phalanx','Stoneskin','Aquaveil','Temper','Temper II','Shellra V','Protectra V'}:contains(spell.english)
            and not S{'Regen','Refresh','BarElement','BarStatus','EnSpell','StatBoost','Teleport'}:contains(default_spell_map) then
                if _settings.debug_mode then
                    add_to_chat(123,'--- FixedPotencyEnhancing ---')
                end 
                return "FixedPotencyEnhancing"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 14)
end
