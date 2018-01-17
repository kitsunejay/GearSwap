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
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
	
	
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells

    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	    -- Fast Cast caps 80%; WHM JT: 0% /SCH LA 10%
        --      46/ 80%
    sets.precast.FC = {
        main="Marin Staff +1",              --3%
        sub="Clerisy Strap",                --2%
        ammo="Incantor Stone",              --2%
        head=gear.chironic_head_curepot,    
        neck="Orison Locket",               --5%
        ear1="Etiolation Earring",          --1%
        ear2="Loquacious Earring",          --2%
        body="Inyanga Jubbah",              --10%
        hands="Fanatic Gloves",             --5%
        ring1="Defending Ring",
        ring2="Kishar Ring",                --5%
        back="Solemnity Cape",
        waist="Cetl Belt",
        legs="Kaykaus Tights",              --6%
        feet="Regal Pumps +1"               --5-7%
    }
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	    -- Fast Cast caps 80%; WHM JT: 0% /SCH LA 10%
        --      69/ 80% CCT+FC 
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        main="Queller Rod",             --7%
        sub="Genmei Shield",
        ear1="Nourishing Earring +1",   --4%
        ear2="Mendicant's Earring",     --5%
        legs="Ebers Pantaloons +1",     --13%
        back="Pahtli Cape"              --8%
    })
  
	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        head="Ayanmo Zucchetto +1",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Ayanmo Cosciales +1",feet="Ayanmo Gambieras +1"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Inyanga Dastanas +1",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    -- Cure sets
        -- Maximum 50% Cure Potency
        -- Maximum 30% Cure Potency II
        -- Maximum -50 Enmity
    gear.default.obi_waist = "Hachirin-no-obi"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Divinity",sub="Genmei Shield",ammo="Incantor Stone",
        head="Ebers Cap",neck="Nodens Gorget",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Ebers Bliaud",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
        back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Medium's Sabots"}

    -- 41/50% CP, 2/30% CP2   |   -19/50 Enmity   |   Skill 0/500
    sets.midcast.Cure = {
        main="Queller Rod",             --10% CP, -10 enmity
        sub="Genmei Shield",
        ammo="Incantor Stone",
        head="Ebers Cap",               --13% CP
        neck="Nodens Gorget",           --5%  CP
        ear1="Glorious Earring",        --2%  CPII , -5 enmity
        ear2="Nourishing Earring +1",   --6-7 CP
        body="Ebers Bliaud",
        hands="Theophany Mitts",        -- -4 enmity
        ring1="Defending Ring",
        ring2="Sirona's Ring",
        back="Alaunus's Cape",
        waist=gear.ElementalObi,
        legs="Ebers Pantaloons +1",
        feet="Vanya Clogs"              -- 7% CP
    }

    sets.midcast.Curaga = {main="Divinity",sub="Genmei Shield",ammo="Incantor Stone",
        head="Ebers Cap",neck="Nodens Gorget",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Ebers Bliaud",hands="Theophany Mitts",ring1="Defending Ring",ring2="Sirona's Ring",
        back="Solemnity Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Medium's Sabots"}

    sets.midcast.CureMelee = {ammo="Incantor Stone",
        head="Ebers Cap",neck="Nodens Gorget",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Ebers Bliaud",hands="Bokwus Gloves",ring1="Defending Ring",ring2="Sirona's Ring",
        back="Tuilha Cape",waist=gear.ElementalObi,legs="Ebers Pantaloons +1",feet="Medium's Sabots"}
    
    sets.midcast.CureSelf = {ring1="Vocane Ring",ring2="Defending's Ring",waist="Gishdubar Sash"}

    sets.midcast.Cursna = {main="Beneficus",sub="Genmei Shield",
        head="Ebers Cap",neck="Incanter's Torque",
        body="Ebers Bliaud",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Alaunus's Cape",waist="Goading Belt",legs="Theophany Pantaloons +1",feet="Gendewitha Galoshes"}

    sets.midcast.StatusRemoval = {
        head="Ebers Cap",legs="Ebers Pantaloons +1"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Queller Rod",sub="Ammurapi Shield",
        head="Befouled Crown",neck="Incanter's Torque",
        body="Telchine Chasuble",hands="Inyanga Dastanas +1",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Stoneskin = {
        head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Inyanga Dastanas +1",
        back="Swith Cape +1",waist="Siegel Sash",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.midcast.Auspice = {hands="Inyanga Dastanas +1",feet="Ebers Duckbills"}

    sets.midcast.BarElement = {main="Beneficus",sub="Genmei Shield",
        head="Ebers Cap",neck="Incanter's Torque",
        body="Ebers Bliaud",hands="Ebers Mitts",
        back="Mending Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Regen = {main="Bolelabunga",sub="Genmei Shield",
        head="Inyanga Tiara +1",
        body="Piety Briault",
        hands="Ebers Mitts",
        legs="Theophany Pantaloons +1"}

    sets.midcast.Protectra = {ring1="Sheltered Ring",feet="Medium's Sabots"}

    sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {main="Queller Rod",sub="Genmei Shield",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
        back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons +1",feet="Gendewitha Galoshes"}

    sets.midcast['Dark Magic'] = {main="Queller Rod", sub="Genmei Shield",
        head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Medium's Sabots"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Medium's Sabots"}

    sets.midcast.IntEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Medium's Sabots"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Witching Robe",hands="Serpentes Cuffs",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Witful Belt",legs="Lengo Pants",feet="Crier's Gaiters"}

    sets.idle.PDT = {main="Queller Rod", sub="Genmei Shield",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Solemnity Cape",waist="Witful Belt",legs="Assiduty Pants +1",feet="Crier's Gaiters"}

    sets.idle.Town = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Incanter's Torque",ear1="Glorious Earring",ear2="Nourishing Earring +1",
        body="Witching Robe",hands=gear.chironic_hands_refresh,ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Solemnity Cape",waist="Witful Belt",legs="Ebers Pantaloons +1",feet="Crier's Gaiters"}
    
    sets.idle.Weak = {main="Queller Rod",sub="Genmei Shield",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
        back="Solemnity Cape",waist="Witful Belt",legs="Nares Trews",feet="Gendewitha Galoshes"}
    
    -- Defense sets

    sets.defense.PDT = {main="Queller Rod", sub="Genmei Shield",
        head="Ebers Cap",neck="Twilight Torque",
        body="Witching Robe",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Solemnity Cape",legs="Ayanmo Cosciales +1",feet=gear.chironic_feet_refresh}

    sets.defense.MDT = {main="Queller Rod", sub="Genmei Shield",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Inyaga Jubbah",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",legs="Ayanmo Cosciales +1",feet=gear.chironic_feet_refresh}

    sets.Kiting = {feet="Crier's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Ayanmo Zucchetto +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Petrov Ring",ring2="Apate Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Ayanmo Cosciales +1",feet="Ayanmo Gambieras +1"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
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
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
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
