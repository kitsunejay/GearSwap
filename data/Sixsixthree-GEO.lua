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
    --include('Mote-TreasureHunter')

    
    indi_timer = ''
    indi_duration = 180
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT','Refresh')

	state.MagicBurst = M(false, 'Magic Burst')

    -- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()

    set_lockstyle(1)
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic +2"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +2",back=gear.nantosuleta_pet_regen}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}

    -- Fast cast sets for spells

    sets.precast.FC = {
        range="Dunna",                    --3
        head=gear.merlinic_head_fc,         --14    
        neck="Baetyl Pendant",              --4
        ear1="Malignance Earring",          --4
        ear2="Etiolation Earring",          --1
        body="Shango Robe",
        hands=gear.merlinic_hands_fc,       --6
        ring1="Defending Ring",
        ring2="Kishar Ring",                --4
        back=gear.natosuleta_fc,            --10
        waist="Embla Sash",
        legs="Geomancy Pants +2",           --13
        feet=gear.merlinic_feet_fc          --11
    }
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        main="Tamaxchi",sub="Genbu's Shield",
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Telos Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Relucent Cape",waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Strendu Ring",
        back=gear.natosuleta_mab,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head=gear.merlinic_head_fc,neck="Baetyl Pendant",ear1="Loquacious Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Bokwus Gloves",ring2="Kishar Ring",
        back="Swith Cape +1",waist="Embla Sash",legs="Geomancy Pants +2",feet="Hagondes Sabots"}

    --- 900+ skill
    sets.midcast.Geomancy = {
        main="Idris",
        sub="Genbu's Shield",
        range="Dunna",
        head="Vanya Hood",
        neck="Incanter's Torque",
        ear1="Calamitous Earring",
        ear2="Etiolation Earring",
        body="Bagua Tunic +2",
        hands="Shrieker's Cuffs",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=gear.lifestream_pet_dt,
        waist="Austerity Belt",
        legs="Vanya Slops",
        feet=gear.merlinic_feet_th
    }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
        body="Bagua Tunic +2",
        back=gear.nantosuleta_pet_regen,
        legs="Bagua Pants +1",
        feet="Azimuth Gaiters +1"
    })
    
    sets.midcast["Elemental Magic"] = {    
        main="Idris",sub="Ammurapi Shield",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Freke Ring",right_ring="Acumen Ring",
        back=gear.natosuleta_mab,waist="Eschan Stone", legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
    
    
    sets.midcast.GeoElem = sets.midcast["Elemental Magic"]

    sets.midcast["Enfeebling Magic"] = {    
        main="Idris",sub="Ammurapi Shield",
        head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Gwati Earring",
        body="Geomancy Tunic +2",hands="Geomancy Mitaines +3",left_ring="Jhakri Ring",right_ring="Kishar Ring",
        back=gear.natosuleta_cure,waist="Luminary Sash",legs="Geomancy Pants +2",feet="Geomancy Sandals +3"}

    sets.midcast["Dark Magic"] = {    
        main="Rubicundity",sub="Ammurapi Shield",
        head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Gwati Earring",
        body="Geomancy Tunic +2",hands="Geomancy Mitaines +3",left_ring="Jhakri Ring",right_ring="Kishar Ring",
        back=gear.natosuleta_mab,waist="Luminary Sash",legs="Geomancy Pants +2",feet="Geomancy Sandals +3"}    

    sets.midcast.Drain = {
        main="Rubicundity",sub="Ammurapi Shield",
        head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Malignance Earring",ear2="Gwati Earring",
        body="Geomancy Tunic +2",hands="Geomancy Mitaines +3",left_ring="Jhakri Ring",right_ring="Kishar Ring",
        back=gear.lifestream_pet_dt,waist="Eschan Stone",legs="Geomancy Pants +2",feet="Geomancy Sandals +3"}    

    sets.midcast.Aspir = sets.midcast.Drain
    
    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --9%
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --10%
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        waist="Embla Sash",                 --10%
        legs=gear.telchine_legs_enh_dur,    --9%(aug)
        feet=gear.telchine_feet_enh_dur     --9%
    }
    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration
    sets.midcast["Enhancing Magic"] = set_combine(sets.midcast.EnhancingDuration, {
        
    })
    sets.midcast.Cure = {main="Gada",sub="Sors Shield",
        head="Vanya Hood",neck="Incanter's Torque",ear1="Mendicant's Earring",ear2="Meili Earring",
        body="Vanya Robe",hands="Vanya Cuffs",ring1="Janniston Ring",ring2="Sirona's Ring",
        back=gear.natosuleta_cure,waist="Belisama's Rope",legs="Vanya Slops",feet="Vanya Clogs"}
    
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Gishdubar Sash"}
    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        neck="Nodens Gorget",
        waist="Hachirin-no-Obi",
    }

    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        main="Gada",sub="Sors Shield",
        neck="Incanter's Torque",
        feet="Vanya Clogs"
    })

    sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna, {waist="Gishdubar Sash"})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}

    -- Idle sets

    sets.idle = {main="Idris",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head=gear.merlinic_head_refresh,neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Eschan Stone",legs="Assiduity Pants +1",feet="Geomancy Sandals +3"}

    sets.idle.DT = {main="Idris",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Eschan Stone",legs="Geomancy Pants +2",feet="Geomancy Sandals +3"}

    sets.idle.Refresh = {main="Idris",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head=gear.merlinic_head_refresh,neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Eschan Stone",legs="Assiduity Pants +1",feet=gear.merlinic_feet_refresh}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body=gear.telchine_body_pet_dt,hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Isa Belt",legs=gear.telchine_legs_pet_dt,feet=gear.telchine_feet_pet_dt}

    sets.idle.DT.Pet = {main="Idris",sub="Genbu's Shield",ammo="Staunch Tathlum",
        head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Isa Belt",legs=gear.telchine_legs_pet_dt,feet="Mallquis Clogs +2"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {legs="Geomancy Pants +2",feet="Geomancy Sandals +3"})
    sets.idle.Pet.Indi = sets.idle.Pet
    sets.idle.DT.Indi = set_combine(sets.idle.DT, {legs=gear.telchine_legs_pet_dt, feet="Mallquis Clogs +2"})
    sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {legs=gear.telchine_legs_pet_dt, feet="Mallquis Clogs +2"})

    sets.idle.Town = {main="Idris",sub="Ammurapi Shield",range="Dunna",
        head="Azimuth Hood +1",neck="Incanter's Torque",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Geomancy Tunic +2",hands="Geomancy Mitaines +3",ring1="Freke Ring",ring2="Warp Ring",
        back=gear.nantosuleta_pet_regen,waist="Embla Sash",legs=gear.telchine_legs_pet_dt,feet="Geomancy Sandals +3"}

    sets.idle.Weak = {main="Idris",sub="Genbu's Shield",range="Dunna",
        head="Nefer Khat +1",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Austerity Belt",legs="Geomancy Pants +2",feet="Geomancy Sandals +3"}

    -- Defense sets

    sets.defense.PDT = {range="Dunna",
        head="Hagondes Hat",neck="Loricate Torque +1",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.nantosuleta_pet_regen,waist="Goading Belt",legs="Geomancy Pants +2",feet="Mallquis Clogs +2"}

    sets.defense.MDT = {range="Dunna",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Shadow Ring",
        back=gear.nantosuleta_pet_regen,waist="Goading Belt",legs="Geomancy Pants +2",feet="Mallquis Clogs +2"}

    sets.Kiting = {feet="Geomancy Sandals +3"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.magic_burst = { 
        neck="Mizukage-no-kubikazari",
        body="Ea Houppelande",          --t2 9% / t1 9%
        ring2="Locus Ring",				--t2 5%
    }
    
    sets.TreasureHunter = {
       waist="Chaac Belt",}
        
    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {main="Idris",sub="Ammurapi Shield",range="Dunna",    
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Telos Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Apate Ring",
        back="Relucent Cape",waist="Cetl Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}


    sets.engaged.DW = {main="Idris",sub="Ammurapi Shield",range="Dunna",    
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Apate Ring",
        back="Relucent Cape",waist="Cetl Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell)
    checkblocking(spell)
    --[[
    if spell.action_type == 'Magic' then
        if aftercast_start and os.clock() - aftercast_start < waittime then
            windower.add_to_chat(8,"Precast too early! Adding Delay:"..waittime - (os.clock() - aftercast_start))
            cast_delay(waittime - (os.clock() - aftercast_start))
        end
    end
    ]]
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
        equip(sets.midcast.CursnaSelf)
    end

	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end

    -- Weather checks
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.skill == "Elemental Magic" then
                equip({waist="Hachirin-no-Obi",})
                if _settings.debug_mode then
                    add_to_chat(123,'--- Equiping obi for Elemental ---')
                end
            elseif spellMap == "Cure" then
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
            end
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
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not S{'strap','grip'}:contains(player.equipment.sub:lower()) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
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
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
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
    set_macro_page(1, 6)
end
