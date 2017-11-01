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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')

    gear.default.obi_waist = "Sekhmet Corset"
	
	-- Ambuscade Capes

    gear.sucellos_mab	={	name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10'}}
    gear.sucellos_macc 	={	name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20'}}   
		
	-- Ru'an
	gear.amalric_legs_A ={ name="Amalric Slops", augments={'"Mag. Atk. Bns." +15', 'Mag. Acc. +15', 'MP +60'}}
	
	-- Reisenjima 
	-- -> in Mote-Globals
	
	-- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +2",
        body="Atrophy Tabard +2",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants +1",feet="Jhakri Pigaches +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps 80%; RDM JT: 30%
        -- JP "Fast Cast Effect" 0/8
    sets.precast.FC = {ammo="Hydrocera",
        main="Marin Staff +1",      --3%
        sub="Clerisy Strap",        --2%
        head="Atrophy Chapeau +2",	--12%
		ear1="Estoqueur's Earring",	--2%
		ear2="Loquacious Earring",	--2%
        body="Vitivation Tabard",	--12%
		hands="Leyline Gloves", 	--7%
		ring1="Jhakri Ring",
		ring2="Defending Ring",
		legs="Lengo Pants", 		--5%
		feet="Merlinic Crackows",	--8%
		}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {back="Pahtli Cape"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
        head="Ayanmo Zucchetto +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Atheling Mantle",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
		--~73% MND
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Soil Gorget",
        ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

        --80% DEX
	sets.precast.WS['Chant du Cygne'] = {ammo="Ginsen",
        head="Jhakri Coronal +1",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Jhakri Cuffs +1",ring1="Apate Ring",ring2="Begrudging Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Jhakri Slops +1",feet="Ayanmo Gambieras +1"}

        
    sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Toro Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}
		
		--40% DEX / 40% INT / Magical
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, { ammo="Ghastly Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Acumen Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"})
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +2",ear2="Loquacious Earring",
        body="Vitivation Tabard",hands="Leyline Gloves",
        back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet=gear.merlin_feet_fc}

	--Cure potency > 50%    |   Enmity - 33
    sets.midcast.Cure = { ammo="Hydrocera",
        head=gear.chironic_head_curepot,
		neck="Nodens Gorget",
		ear1="Calamitous Earring",
		ear2="Gwati Earring",
        body="Vanya Robe",
		hands="Chironic Gloves",
		ring1="Perception Ring",
		ring2="Sirona's Ring",
        back="Solemnity Cape",
		waist="Salire Belt",
		legs="Adhara Seraweels",
		feet="Medium's Sabots"}
    
	sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Vocane Ring",ring2="Sirona's Ring"}

    sets.midcast['Enhancing Magic'] = {
        head="Atrophy Chapeau +2",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vitivation Tabard",hands="Chironic Gloves",ring1="Perception Ring",ring2="Jhakri Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Warlock's Tights",feet="Lethargy Houseaux"}

    sets.midcast.Refresh = {body="Atrophy Tabard +2",legs="Lethargy Fuseau"}

    sets.midcast.Stoneskin = {neck="Nodens Gorget", waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {ammo="Hydrocera",
        head="Atrophy Chapeau +2",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Atrophy Tabard +2",hands=gear.chironic_hands_macc,ring1="Perception Ring",ring2="Jhakri Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs=gear.chironic_pants_macc,feet="Medium's Sabots"}

	-- Cant be resisted so go full potency
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
        head="Vitivation Chapeau",
        body="Lethargy Sayon",
    })
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Duelist's Tights +2"})
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Duelist's Tights +2"})
    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots"})
	
    sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Acumen Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {ammo="Hydrocera",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Psycloth Vest",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Evanescence Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ring2="Evanescence Ring",
        waist="Fucho-no-Obi"
    })

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
        hands="Atrophy Gloves",     --15%
        body="Telchine Chausuble",   --8%(aug) // max 10%
        back=gear.sucellos_macc,    --20%
        feet="Lethargy Houseaux"    --25%
    }
        
    sets.buff.ComposureOther = {
        head="Lethargy Chappel",
        body="Lethargy Sayon",
        hands="Lethargy Gantherots",
        legs="Lethargy Fuseau",
        feet="Lethargy Houseaux"
    }
	-- 40% magic burst gear
	-- 
    sets.magic_burst = { 
		head=gear.merlin_head_mbd,		-- 	7%	
		neck="Mizukage-no-Kubikazari", 	-- 	10%
		hands="Amalric Gages", 			--t2 5%
		ring1="Mujin Band",			    --t2 5%
		ring2="Locus Ring",				--	5%
		feet="Jhakri Pigaches +2"		--	7%
	}
    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitivation Chapeau",neck="Sanctity Necklace", 
        body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Duelist's Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {ammo="Homiliary",
        head="Vitivation Chapeau",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Lengo Pants",feet=gear.chironic_feet_refresh}

    sets.idle.Town = {main="Chicken Knife II",sub="Genbu's Shield",ammo="Homiliary",
        head="Vitivation Chapeau",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Loquacious Earring", 
        body="Ayanmo Corazza +1",hands=gear.chironic_hands_refresh,ring1="Defending Ring",ring2="Warp Ring",
        back=gear.sucellos_macc,waist="Fotia Belt",legs="Lengo Pants",feet=gear.chironic_feet_refresh}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Homiliary",
        head="Vitivation Chapeau",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Serpentes Cuffs",ring1="Vocane Ring",ring2="Defending Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Lengo Pants",feet=gear.chironic_feet_refresh}

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Sanctity Necklace",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Ayanmo Cosciales +1",feet=gear.chironic_feet_refresh}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Ayanmo Cosciales +1",feet=gear.chironic_feet_refresh}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +2",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Vocane Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Ayanmo Cosciales +1",feet="Jhakri Pigaches +2"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +2",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +2",hands="Ayanmo Manopolas +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Ayanmo Cosciales +1",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Ayanmo Zucchetto +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Xucau Mantle",waist="Eschan Stone",legs="Ayanmo Cosciales +1",feet="Ayanmo Gambieras +1"}

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +2",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Defending Ring",ring2="Vocane Ring",
        back="Xucau Mantle",waist="Goading Belt",legs="Ayanmo Cosciales +1",feet="Jhakri Pigaches +2"}

	sets.engaged.DW = {ammo="Ginsen",
        head="Ayanmo Zucchetto +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Ayanmo Corazza +1",hands="Ayanmo Manopolas +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Xucau Mantle",waist="Eschan Stone",legs="Ayanmo Cosciales +1",feet="Ayanmo Gambieras +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if state.CastingMode.value == "Resistant" then
			equip(set_combine(sets.midcast['Elemental Magic'].Resistant, sets.magic_burst))
		else
			equip(set_combine(sets.midcast['Elemental Magic'], sets.magic_burst))
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end
