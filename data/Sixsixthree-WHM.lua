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
    state.IdleMode:options('Normal', 'Refresh', 'DT')

    select_default_macro_book()
	
    set_lockstyle(2)

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
        ammo="Incantor Stone",              --2%
        head="Nahtirah Hat",                --10%    
        neck="Baetyl Pendant",              --4%
        ear1="Etiolation Earring",          --1%
        ear2="Loquacious Earring",          --2%
        body="Inyanga Jubbah +2",           --10%
        hands="Fanatic Gloves",             --5%
        ring1="Defending Ring",
        ring2="Kishar Ring",                --5%
        back="Alaunus's Cape",              --10%
        waist="Embla Sash",                 --5%
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
        legs="Ebers Pantaloons +1",     --10%
    })
  
	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",
        body="Inyanga Jubbah +2",
        back="Refraction Cape",feet="Gendewitha Galoshes +1"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        head="Ayanmo Zucchetto +2",neck=gear.ElementalGorget,ear1="Cessance Earring",ear2="Moonshade Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
    
    sets.precast.WS['Flash Nova'] = {range="Pemphredo Tathlum",
        head="Nahtirah Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Shiva Ring +1",ring2="Acumen Ring",
        back="Toro Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Inyanga Crackows +2"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands="Inyanga Dastanas +2",
        back="Alaunus's Cape",waist="Cetl Belt",legs=gear.telchine_legs_enh_dur,feet="Gendewitha Galoshes +1"}
    
    -- Cure sets
        -- Maximum 50% Cure Potency
        -- Maximum 30% Cure Potency II
        -- Maximum -50 Enmity

    -- 41/50% CP, 2/30% CP2   |   -19/50 Enmity   |   Skill 0/500
    sets.midcast.Cure = {
        main="Quller Rod",              --10% CP, -10 enmity
        sub="Sors Shield",
        ammo="Elis Tome",
        head="Vanya Hood",              --13% CP
        neck="Incanter's Torque",           --5%  CP
        ear1="Mendicant's Earring",     --5%  CP
        ear2="Nourishing Earring +1",   --6-7 CP
        body="Ebers Bliaud +1",
        hands="Inyanga Dastanas +2",
        ring1="Janniston Ring",
        ring2="Sirona's Ring",
        back="Alaunus's Cape",
        waist="Luminary Sash",
        legs="Ebers Pantaloons +1",
        feet="Vanya Clogs"              -- 7% CP
    }
    sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{
        body="Ebers Bliaud +1",
        back="Alaunus's Cape"
    })

    sets.midcast.Curaga = {main="Bolelabunga",sub="Genbu's Shield",ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Nodens Gorget",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Ebers Bliaud +1",hands="Inyanga Dastanas +2",ring1="Lebeche Ring",ring2="Sirona's Ring",
        back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Vanya Hood",neck="Nodens Gorget",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Ebers Bliaud +1",hands="Inyanga Dastanas +2",ring1="Lebeche Ring",ring2="Sirona's Ring",
        back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}
    
    sets.midcast.CureSelf = {ring1="Defending Ring",ring2="Gelatinous Ring +1",waist="Gishdubar Sash"}

    sets.midcast.CureWeather = {
        main="Chatoyant Staff",         --10% CP
        sub="Enki Strap",
        neck="Nodens Gorget",
        waist="Hachirin-no-Obi",
    }

    sets.midcast.CuragaWeather = {
        main="Chatoyant Staff",         --10% CP
        sub="Enki Strap",
        waist="Hachirin-no-Obi",
        back="Twilight Cape"}   

    sets.midcast.Cursna = {main="Gada",sub="Genbu's Shield",
        head="Vanya Hood",neck="Incanter's Torque",
        body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Alaunus's Cape",waist="Cetl Belt",legs="Theophany Pantaloons +1",feet="Gendewitha Galoshes +1"}

    sets.midcast.StatusRemoval = {
        head="Ebers Cap +1",legs="Ebers Pantaloons +1"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
        head="Befouled Crown",neck="Incanter's Torque",
        body="Telchine Chasuble",hands="Inyanga Dastanas +2",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}

    sets.midcast.Erase = set_combine(sets.midcast.FastRecast,{neck="Cleric's Torque"})

    sets.midcast.Stoneskin = {
        head="Nahtirah Hat",neck="Nodens Gorget",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",
        back="Swith Cape +1",waist="Siegel Sash",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}

    sets.midcast.Auspice = {hands="Inyanga Dastanas +2",feet="Ebers Duckbills +1"}

    sets.midcast.BarElement = {main="Beneficus",sub="Genbu's Shield",
        head="Ebers Cap +1",neck="Incanter's Torque",
        body="Ebers Bliaud +1",hands="Ebers Mitts +1",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}



    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --10%
        legs=gear.telchine_legs_enh_dur,    --10%(aug)
        wait="Embla Sash",                  --10%
        feet=gear.telchine_feet_enh_dur     --9%
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration,{
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Inyanga Tiara +2",
        body="Piety Briault",
        hands="Ebers Mitts +1",
        legs="Theophany Pantaloons +1"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration,{feet="Ebers Duckbills +1"})

    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration

    sets.midcast.Shellra = set_combine(sets.midcast.EnhancingDuration,{legs="Piety Pantaloons +1"})
    sets.midcast.Protectra = set_combine(sets.midcast.EnhancingDuration,{feet="Piety Duckbills"})

    sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Genbu's Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Stikini Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons +1",feet="Gendewitha Galoshes +1"}

    sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Genbu's Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Shango Robe",hands="Inyanga Dastanas +2",ring1="Stikini Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Luminary Sash",legs=gear.chironic_pants_macc,feet="Medium's Sabots"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Gada", sub="Ammurapi Shield",ammo="Hydrocera",
        head="Befouled Crown",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Theophany Briault",hands="Kaykaus Cuffs",ring1="Sangoma Ring",ring2="Stikini Ring",
        back="Aurist's Cape",waist="Luminary Sash",legs=gear.chironic_legs_macc,feet="Medium's Sabots"}

    sets.midcast.IntEnfeebles = {main="Gada",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Vanya Robe",hands="Kaykaus Cuffs",ring1="Sangoma Ring",ring2="Stikini Ring",
        back="Aurist's Cape",waist="Rumination Sash",legs=gear.chironic_legs_macc,feet="Medium's Sabots"}

    sets.midcast['Repose'] = sets.midcast.MndEnfeebles
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = sets.idle
    

    -- Idle sets
    sets.idle = {main="Daybreak", sub="Genbu's Shield",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",waist="Eschan Stone",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    sets.idle.Refresh = {main="Daybreak", sub="Genbu's Shield",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",waist="Eschan Stone",legs="Assiduity Pants +1",feet="Inyanga Crackows +2"}

    sets.idle.DT = {main="Daybreak", sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",waist="Eschan Stone",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}

    sets.idle.Town = {main="Daybreak", sub="Genbu's Shield",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Ebers Bliaud +1",hands="Inyanga Dastanas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Alaunus's Cape",waist="Eschan Stone",legs="Ebers Pantaloons +1",feet="Herald's Gaiters"}
    
    sets.idle.Weak = {main="Daybreak",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Ebers Bliaud +1",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",waist="Witful Belt",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}
    
    -- Defense sets

    sets.defense.PDT = {main="Daybreak", sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",legs="Ayanmo Cosciales +2",feet="Inyanga Crackows +2"}

    sets.defense.MDT = {main="Daybreak", sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Alaunus's Cape",legs="Ayanmo Cosciales +2",feet="Inyanga Crackows +2"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Ayanmo Zucchetto +2",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Telos Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
    
    sets.engaged.DW = {
        head="Ayanmo Zucchetto +2",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
    

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell)
    checkblocking(spell)
end

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
                equip(set_combine(sets.midcast['Elemental Magic'], {waist="Hachirin-no-Obi",}))
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
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
