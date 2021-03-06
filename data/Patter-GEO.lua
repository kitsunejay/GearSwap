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
    state.IdleMode:options('Normal', 'DT')

    gear.lifestream_pet_dt = { name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +10','Pet: Damage taken -3%','Damage taken-5%',}}

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic"}
    sets.precast.JA['Full Circle'] = {body="Azimuth Hood"}

    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head=gear.merlinic_head_fc,neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",ring1="Kishar Ring",
        back=gear.lifestream_pet_dt,waist="Witful Belt",legs="Geomancy Pants",feet=gear.merlinic_feet_fc}
    
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {body="Mallquis Saio +2",hands="Bagua Mitaines"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +1",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe",hands="Jhakri Gloves +2",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Relucent Cape",waist=gear.ElementalBelt,legs="Hagondes Pants",feet="Jhakri Pigaches +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
        head="Hagondes Hat",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jhakri Robe",hands="Jhakri Gloves +2",ring1="Acumen Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Snow Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +1"}

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head=gear.merlinic_head_fc,neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Mallquis Saio +2",hands="Bokwus Gloves",ring1="Kishar Ring",
        back="Swith Cape +1",waist="Cetl Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    --- 876 skill
    sets.midcast.Geomancy = {
        main="Solstice",
        sub="Genbu's Shield",
        range="Dunna",
        head="Azimuth Hood",
        neck="Incanter's Torque",
        body="Bagua Tunic", 
        hands="Geomancy Mitaines",
        ring2="Stikini Ring"
    }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
        legs="Bagua Pants",
        feet="Azimuth Gaiters"
    })
    
    sets.midcast["Elemental Magic"] = {    
        main="Solstice",sub="Genbu's Shield",ammo="Kalboron Stone",
        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Friomisi Earring",ear2="Gwati Earring",
        body="Jhakri Robe",hands="Jhakri Cuffs +1",left_ring="Jhakri Ring",right_ring="Perception Ring",
        back="Lifestream Cape",waist="Austerity Belt",back=gear.lifestream_pet_dt, legs="Jhakri Slops +2",feet="Jhakri Pigaches +1"
    }
    sets.midcast["Enfeebling Magic"] = sets.midcast["Elemental Magic"]


    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --10%
        legs=gear.telchine_legs_enh_dur,    --10%(aug)
        --back=gear.ghostfyre_dur,            --18/20%*
        feet=gear.telchine_feet_enh_dur     --9%
    }
    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",
        head="Vanya Hood",ear1="Mendicant's Earring",ear2="Calamitous Earring",
        body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Haoma Ring",ring2="Sirona's Ring",
        back="Swith Cape +1",legs="Nares Trews",feet="Vanya Clogs"}
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}

    -- Idle sets

    sets.idle = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Befouled Crown",neck="Loricate Torque",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Jhakri Robe",hands="Bagua Mitaines",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Lifestream Cape",waist="Austerity Belt",legs="Geomancy Pants",feet="Geomancy Sandals"}

    sets.idle.DT = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Nahtirah Hat",neck="Loricate Torque",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Geomancy Pants",feet="Geomancy Sandals"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Azimuth Hood",neck="Loricate Torque",ear1="Handler's Earring",ear2="Etiolation Earring",
        body="Jhakri Robe",hands="Geomancy Mitaines",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Lifestream Cape",waist="Isa Belt",legs=gear.telchine_legs_pet_dt,feet="Mallquis Clogs +1"}

    sets.idle.DT.Pet = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Nahtirah Hat",neck="Loricate Torque",ear1="Infused Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +2",hands="Geomancy Mitaines",ring1="Defending Ring",ring2="K'ayres Ring",
        back="Lifestream Cape",waist="Isa Belt",legs=gear.telchine_legs_pet_dt,feet="Mallquis Clogs +1"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {legs="Geomancy Pants",feet="Mallquis Clogs +1"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {legs=gear.telchine_legs_pet_dt, feet="Mallquis Clogs +1"})
    sets.idle.DT.Indi = set_combine(sets.idle.DT, {legs=gear.telchine_legs_pet_dt, feet="Mallquis Clogs +1"})
    sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {legs=gear.telchine_legs_pet_dt, feet="Mallquis Clogs +1"})

    sets.idle.Town = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Azimuth Hood",neck="Incanter's Torque",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Jhakri Robe",hands="Geomancy Mitaines",ring1="Jhakri Ring",ring2="Warp Ring",
        back="Lifestream Cape",waist="Isa Belt",legs=gear.telchine_legs_pet_dt,feet="Geomancy Sandals"}

    sets.idle.Weak = {main="Solstice",sub="Genbu's Shield",range="Dunna",
        head="Befouled Crown",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Lifestream Cape",waist="Austerity Belt",legs="Geomancy Pants",feet="Geomancy Sandals"}

    -- Defense sets

    sets.defense.PDT = {range="Dunna",
        head="Hagondes Hat",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Mallquis Saio +2",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Lifestream Cape",waist="Goading Belt",legs="Geomancy Pants",feet="Mallquis Clogs +1"}

    sets.defense.MDT = {range="Dunna",
        head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Lifestream Cape",waist="Goading Belt",legs="Geomancy Pants",feet="Mallquis Clogs +1"}

    sets.Kiting = {feet="Geomancy Sandals"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {range="Dunna",    
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Steelflash Earring",
        body="Jhakri Robe",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Apate Ring",
        back="Relucent Cape",waist="Cetl Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +1"}


    sets.engaged.DW = {range="Dunna",    
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Jhakri Robe",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Apate Ring",
        back="Relucent Cape",waist="Cetl Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +1"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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
