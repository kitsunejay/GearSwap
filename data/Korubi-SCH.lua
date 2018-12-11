-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	state.MagicBurst = M(false, 'Magic Burst')

    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

	send_command('bind !` gs c toggle MagicBurst')
	send_command('bind ^` input /ma Stun <t>')

    select_default_macro_book()


    gear.lugh_fc    =  { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
    gear.lugh_mab   =  { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

    set_lockstyle(13)

end

function user_unload()
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}


    -- Fast cast sets for spells
	    -- Fast Cast caps at 80%; SCH JT: 0%
		
		-- Current = 53%
    sets.precast.FC = {
		ammo="Incantor Stone",			--2%
        head=gear.merlin_head_fc, 		--13%
        neck="Baetyl Pendant",          --4%
        ear1="Etiolation Earring",      --1%
		ear2="Loquacious Earring", 		--2%
        body=gear.merlin_body_fc,       --11%
		hands="Gendewitha Gages +1",	--7%
		ring1="Defending Ring",
		ring2="Kishar Ring",			-- 5%
		back=gear.lugh_fc,			    -- 10%
		waist="Cetl Belt",				-- //haste5%
		legs="Psycloth Lappas",			--7%
        feet=gear.merlin_feet_fc        --12%
    }		

    sets.precast.FC.Grimoire = {head="Pedagogy Mortarboard +1", feet="Academic's Loafers +2"}
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,{
        ear1="Barkarole Earring",
        ring1="Mallquis Ring",
    })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
		head=empty,body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {ammo="Strobilus",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Evans Earring",ear2="Etiolation Earring",
        body="Amalric Doublet +1",hands="Telchine Gloves",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back="Pahtli Cape",waist="Shinjutsu-no-obi +1",legs="Amalric Slops",feet="Psycloth Boots"}   

    -- Midcast Sets
	
	-- Base midcast set
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Gendewitha Gages +1",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Cetl Belt",feet="Academic's Loafers +2"
    }

    -- 50% cp1 cap
    sets.midcast.Cure = {ammo="Hydrocera",
        main="Gada",                        --22%
        sub="Genmei Shield",
        head="Vanya Hood",                  --9% 
        neck="Nodens Gorget",               --5%
        ear1="Calamitous Earring",
        ear2="Mendicant's Earring",         --5%
        body="Vanya Robe",
        hands="Kaykaus Cuffs",              --10%
        ring1="Lebeche Ring",               --2%
        ring2="Sirona's Ring",
        back="Solemnity Cape",              --7%
        waist="Luminary Sash",
        legs="Kaykaus Tights",
        feet="Vanya Clogs"                  --5%
    }
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{ring1="Vocane Ring",waist="Gishdubar Sash"})
    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        waist="Hachirin-no-Obi",back="Twilight Cape"
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Regen = {main="Bolelabunga",
        head="Arbatel Bonnet +1",
        body=gear.telchine_body_enh_dur,
		back=gear.lugh_mab,
		}

    sets.midcast.Cursna = {
		body="Vanya Robe",
        ring1="Ephedra Ring",
        }
--[[
    sets.midcast['Enhancing Magic'] = {ammo="Savant's Treatise",
        head="Arbatel Bonnet +1",neck="Colossus's Torque",
        body="Manasa Chasuble",hands="Ayao's Gages",
        waist="Olympus Sash",legs="Portent Pants"}
]]

    sets.midcast['Enhancing Magic'] = {
        main="Gada",         
        sub="Ammurapi Shield",
        head="Befouled Crown",          -- +16
        neck="Incanter's Torque",       -- +10
        ear1="Calamitous Earring",
        ear2="Andoaa Earring",          -- +5
        body=gear.telchine_body_enh_dur,
        hands=gear.telchine_hands_enh_dur,
        ring1="Stikini Ring",           -- +5
        ring2="Defending Ring",
        back="Perimede Cape",           -- +7
        waist="Olympus Sash",           -- +5
        legs="Academic's Pants +2",
        feet=gear.telchine_feet_enh_dur
    }

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
    
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif"})
    
    sets.midcast.Haste = sets.midcast.EnhancingDuration
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif",
        waist="Gishdubar Sash",
    })
        
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet="Pedagogy Loafers"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Arbatel Bonnet +1",
        body=gear.telchine_body_enh_dur,
        back="Bookworm's Cape"
        })

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Gada",sub="Ammurapi Shield",ammo="Hydrocera",
        head=gear.merlin_head_mbd,neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Academic's Gown +2",hands="Kaykaus Cuffs",ring1="Stikini Ring",ring2="Kishar Ring",
        back=gear.lugh_fc,waist="Luminary Sash",legs=gear.chironic_legs_macc,feet="Academic's Loafers +2"}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
        ear1="Barkarole Earring",
    })

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {main="Marin Staff +1",sub="Enki Strap",ammo="Incantor Stone",
	    head=gear.merlin_head_mbd,neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Academic's Gown +2",hands="Kaykaus Cuffs",ring1="Stikini Ring",ring2="Jhakri Ring",
        back=gear.lugh_mab,waist="Eschan Stone",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.midcast.Kaustra = {main="Marin Staff +1",sub="Enki Grip",ammo="Witchstone",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Archon Ring",
        back=gear.lugh_mab,waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    sets.midcast.Drain = {main="Marin Staff +1",sub="Enki Strap",ammo="Incantor Stone",
	    head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Academic's Gown +2",hands="Kaykaus Cuffs",ring1="Stikini Ring",ring2="Jhakri Ring",
        back=gear.lugh_mab,waist="Eschan Stone",legs="Psycloth Lappas",feet=gear.merlin_feet_aspir}

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Apamajas II",sub="Enki Strap",ammo="Pemphredo Tathlum",
	    head=gear.merlin_head_mbd,neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Academic's Gown +2",hands="Kaykaus Cuffs",ring1="Stikini Ring",ring2="Jhakri Ring",
        back=gear.lugh_fc,waist="Luminary Sash",legs="Academic's Pants +2",feet="Academic's Loafers +2"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Marin Staff +1"})


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
            main="Akademos",
            sub="Enki Strap",
            ammo="Pemphredo Tathlum",
            head=gear.merlin_head_mbd,
            neck="Sanctity Necklace",
            ear1="Barkarole Earring",
            ear2="Regal Earring",
            body="Amalric Doublet +1",
            hands="Amalric Gages +1",
            ring1="Shiva Ring +1",
            ring2="Acumen Ring",
            back=gear.lugh_mab,
            waist="Refoccilation Stone",
            legs=gear.merlin_legs_mab,
            feet="Jhakri Pigaches +2"
        }
    sets.midcast['Elemental Magic'].Resistant = {main="Akademos",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Jhakri Ring",ring2="Acumen Ring",
        back=gear.lugh_mab,waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Wizzan Grip"})

    sets.midcast.Impact = {main="Akademos",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=empty,neck="Erra Pendant",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Twilight Cloak",hands=gear.macc_hagondes,ring1="Icesoul Ring",ring2="Sangoma Ring",
        back="Toro Cape",waist="Eschan Stone",legs="Hagondes Pants",feet="Jhakri Pigaches +2"}

    sets.magic_burst = { 
        head=gear.merlin_head_mbd,		-- 	 8%	
        neck="Mizukage-no-Kubikazari", 	-- 	 10%
        body="Amalric Doublet +1",
        hands="Amalric Gages +1", 			--t2 5%
        ring1="Shiva Ring +1",			    
        ring2="Mujin Band",				--t2 5%
        back=gear.lugh_mab,           
        legs=gear.merlin_legs_mbd,      --  6%
        feet="Jhakri Pigaches +2"		--	 7%
        --feet=gear.merlin_feet_mbd       --   8%
    }

    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Pedagogy Mortarboard +1",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Regal Earring",
        body="Academic's Gown +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Warp Ring",
        back=gear.lugh_mab,waist="Luminary Sash",legs="Academic's Pants +2",feet="Crier's Gaiters"}

    sets.idle.Field = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    sets.idle.Field.PDT = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    sets.idle.Weak = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    -- Defense sets

    sets.defense.PDT = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    sets.defense.MDT = {main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    sets.Kiting = {feet="Crier's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
            head="Jhakri Coronal +2",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Telos Earring",
            body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Jhakri Ring",
            back="Aurist's Cape",waist="Windbuffet Belt +1",legs="Jhakri Slops +2",feet="Battlecast Gaiters"}

    sets.precast.FC['Trust'] = sets.engaged
    sets.midcast['Trust'] = sets.engaged
    
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Savant's Pants +2"}
    sets.buff['Parsimony'] = {legs="Savant's Pants +2"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}

    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    --sets.buff.FullSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring",body="Pedagogy Gown"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if state.CastingMode.value == "Resistant" then
			equip(set_combine(sets.midcast['Elemental Magic'].Resistant, sets.magic_burst))
		else
			equip(set_combine(sets.midcast['Elemental Magic'], sets.magic_burst))
		end
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
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

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
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 17)
end

