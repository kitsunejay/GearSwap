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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    --state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.CastingMode:options('Normal', 'Mid', 'Resistant', 'Proc', 'CMP')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')
    state.ConsMP=M(false, 'Conserve MP')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}


	-- Reisenjima
	-- > in Mote-Globals
	
	-- Additional local binds
    send_command('bind ^` gs c toggle ConsMP')
    send_command('bind !` gs c toggle MagicBurst')
    
    set_lockstyle(7)

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +1", 
        back=gear.taranus_fc
    }

    sets.precast.JA.Manafont = {body="Archmage's Coat +3"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells
        -- Fast Cast caps at 80%; BLM JT: 0%
        -- 
    sets.precast.FC = {
        ammo="Sapience Orb",        --2%
        head=gear.merlin_head_fc,   --15%
        neck="Baetyl Pendant",      --4%
        ear1="Malignance Earring",  --2%
        ear2="Etiolation Earring",  --1%   
        body="Zendik Robe",         --13%
        hands=gear.merlin_hands_fc, --6%
        ring1="Kishar Ring",        --5%
        ring2="Defending Ring",      
        back=gear.taranus_fc,       --10%
        waist="Embla Sash",         --5%
        legs="Psycloth Lappas",     --7%
        feet=gear.merlin_feet_fc    --12%
    }

    -- Fast Cast caps at 80%; BLM Elemental JT: 30%
    --      JP Bonus:   
    
    sets.ConsMP = {body="Spaekona's Coat +3",ear1="Regal Earring"}
    
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Karieyh Ring +1",ring2="Apate Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {
        ammo="Strobilus",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Evans Earring",ear2="Etiolation Earring",
        body="Amalric Doublet +1",hands="Otomi Gloves",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=gear.bane_mp,waist="Shinjutsu-no-obi +1",legs="Amalric Slops +1",feet="Psycloth Boots"}   
    
    ---- Midcast Sets ----

	-- Default midcast set
    sets.midcast.FastRecast = {
        head="Cath Palug Crown",ear2="Loquacious Earring",
        body="Shango Robe",hands=gear.merlin_hands_fc,
        back=gear.taranus_fc,waist="Ninurta's Sash",legs="Psycloth Lappas",feet="Agwu's Pigaches"}

    sets.midcast.Cure = {
        main="Gada",sub="Genmei Shield",
        ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Nodens Gorget",ear1="Meili Earring", ear2="Mendicant's Earring",
        body="Vanya Robe",hands=gear.telchine_hands_enh_dur,ring1="Lebeche Ring",ring2="Stikini Ring +1",
        back="Solemnity Cape",waist="Luminary Sash",legs="Vanya Slops",feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Gishdubar Sash"}

    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        ear1="Regal Earring",
        waist="Hachirin-no-Obi",back="Twilight Cape"
    }

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --9%(aug) // max 10%
        hands=gear.telchine_hands_enh_dur,  --10%(aug)
        legs=gear.telchine_legs_enh_dur,
        back="Perimede Cape",            
        feet=gear.telchine_feet_enh_dur     --9%(aug)       
    }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget"})

    sets.midcast['Enfeebling Magic'] = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Jhakri Cuffs +2",ring1="Kishar Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Luminary Sash",legs="Spaekona's Tonban +3",feet="Agwu Pigaches"}
    
    sets.midcast.ElementalEnfeeble = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Archmage's Petasos +3",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Archmage's Coat +3",hands="Jhakri Cuffs +2",ring1="Kishar Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Luminary Sash",legs="Spaekona's Tonban +3",feet="Archmage's Sabots +3"}
    
    sets.midcast.Refresh = sets.midcast['Enhancing Magic']

    -- Skill based enfeeble
    sets.midcast['Poison II'] = set_combine(sets.midcast['Enfeebling Magic'],{
        head="Befouled Crown",
        neck="Incanter's Torque",
        ear1="Vor Earring",
        body="Spaekona's Coat +3",
        waist="Rumination Sash",
        legs="Psycloth Lappas",
    })

    sets.midcast['Dark Magic'] = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Shango Robe",hands="Jhakri Cuffs +2",ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Eschan Stone",legs="Spaekona's Tonban +3",feet="Agwu Pigaches"}

    sets.midcast.Drain = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body=gear.merlin_body_aspir,hands=gear.merlin_hands_aspir,ring1="Archon Ring",ring2="Evanescence Ring",
        back=gear.taranus_mab,waist="Fucho-no-obi",legs="Spaekona's Tonban +3",feet="Agwu Pigaches"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Shango Robe",hands="Jhakri Cuffs +2",ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Ninurta's Sash",legs="Spaekona's Tonban +3",feet="Agwu Pigaches"}
    
    sets.midcast.Stun.Resistant = {
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +3",hands="Jhakri Cuffs +2",ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Ninurta's Sash",legs="Spaekona's Tonban +3",feet="Agwu Pigaches"}



    -- Elemental Magic sets
		
    sets.midcast['Elemental Magic'] = {
        main="Lathi",
        --main="Raetic Staff +1",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Archmage's Petasos +3",
        neck="Sorcerer's Stole +2",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=gear.taranus_mab,
        waist="Sacro Cord",
        legs="Amalric Slops +1",
        feet="Archmage's Sabots +3"
        --feet="Amalric Nails +1"
    }
    

    
    sets.midcast['Elemental Magic'].Resistant = {ammo="Pemphredo Tathlum",
        head="Archmage's Petasos +3",neck="Sorcerer's Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Archmage's Coat +3",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back=gear.taranus_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Archmage's Sabots +3"}
    
        
    --sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    --sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
        main="Earth Staff", 
        sub="Mephitis Grip",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        body="Shango Robe",
        ring1="Kishar Ring",
        ring2="Defending Ring",
        back="Solemnity Cape",
        waist="Ninurta's Sash",
        legs="Psycloth Lappas"
    }
    sets.midcast['Elemental Magic'].Proc = sets.precast.FC
    
    sets.midcast.Impact = {ammo="Pemphredo Tathlum",
        head=empty,neck="Sorcerer's Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Twilight Cloak",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring +1",
        back=gear.taranus_mab,waist="Sacro Cord",legs="Spaekona's Tonban +3",feet="Archmage's Sabots +3"}

    -- Sets to return to when not performing an action.
    
    -- Resting sets

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Archmage's Coat +3",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Assiduity Pants +1",feet="Crier's Gaiters"}
    
    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
        main="Bolelabunga",sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.PDT = {
        main="Bolelabunga",sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {
        main="Bolelabunga",sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head="Vanya Hood",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Assiduity Pants +1",feet="Nyame Sollerets"}
    
    -- Town gear.
    sets.idle.Town = {
        main="Raetic Staff +1",sub="Alber Strap",
        ammo="Pemphredo Tathlum",
        head="Archmage's Petasos +3",neck="Sorcerer's Stole +2",ear1="Regal Earring",ear2="Malignance Earring",
        body="Ea Houppelande +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back=gear.taranus_mab,waist="Sacro Cord",legs="Ea Slops +1",feet="Crier's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Spaekona's Tonban +3",feet="Archmage's Sabots +3"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Archmage's Petasos +3",neck="Loricate Torque +1",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.taranus_fc,waist="Eschan Stone",legs="Spaekona's Tonban +3",feet="Archmage's Sabots +3"}

    sets.Kiting = {feet="Crier's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {
        main="Malignance Pole",
        sub="Enki Strap",
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Assid. Pants +1",
        feet="Wicce Sabots +1",
        neck="Loricate Torque +1",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Genmei Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Defending Ring",
        back=gear.taranus_mab,
    }

    -- Magic Burst Bonus: Job traits + JP category + Gifts + Gear 
    --      (Theoretical cap at 107% with Amalric Gages +1 +1, 106% otherwise) 
    --      41/40      Gear soft cap,
    --      10/11    Burst II, 
    --      13/13    Job trait, 
    --      20/20    Job point category
    --      16/23      gifts
    sets.magic_burst = { 
        --head=gear.merlin_head_mbd,		-- 	 8%	
        head="Ea Hat +1",		        --t2 7% / t1 7%	
        body="Ea Houppelande +1",       --t2 9% / t1 9%
        hands="Amalric Gages +1", 		--t2 6%
        ring1="Freke Ring",			    
        ring2="Mujin Band",				--t2 5%
        back=gear.taranus_mab,          --   5%
        legs="Ea Slops +1",             --t2 8% / t1 8%
        feet="Amalric Nails +1"

	}
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Nyame Helm",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Telos Earring",
        body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Petrov Ring",ring2="Apate Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.CastingMode.value == 'Proc'then
        classes.CustomClass = 'Proc'
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(set_combine(sets.midcast['Elemental Magic'], {waist="Hachirin-no-Obi",}))
        end
        if spell.english == 'Death' then
            equip(sets.midcast['Death'])
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value and spell.english ~= "Impact" then
        equip(sets.magic_burst)
    end

    if spell.skill == 'Elemental Magic' and state.ConsMP.value and spell.english ~= 'Impact' then
        equip(sets.ConsMP)
        --add_to_chat(121,'Equiping AF+1 body')
    end
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.skill == "Elemental Magic" then
                equip({waist="Hachirin-no-Obi",})
                add_to_chat('Equiping obi for Elemental')
            elseif spellMap == "Cure" then
                if spell.target.type == 'SELF' then
                    equip(set_combine(sets.midcast.CureSelf,sets.midcast.CureWeather))
                    if _settings.debug_mode then
                        add_to_chat(123,'--- Equiping obi for CureSelf w/ Weather ---')
                    end                
                else
                    equip(set_combine(sets.midcast.CureSelf,sets.midcast.CureWeather))
                    if _settings.debug_mode then
                        add_to_chat(123,'--- Equiping obi for CureSelf w/ Weather ---')
                    end                
                end
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    --add_to_chat('-------- Gained Buff: [ '..spell.english..' ] --------' )
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        --elseif spell.skill == 'Elemental Magic' then
         --   state.MagicBurst:reset()
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
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    elseif buff == "Mana Wall" and gain then

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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
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
    set_macro_page(1, 15)
end
