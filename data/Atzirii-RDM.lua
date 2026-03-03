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
    state.Buff.Saboteur = buffactive.saboteur or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal','EnSpell','Acc')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant', 'MaxMACC')
    state.IdleMode:options('Normal', 'DT', 'Turtle', 'Refresh')
    state.WeaponskillMode:options('Normal', 'Acc', 'Proc')

	state.MagicBurst = M(false, 'Magic Burst')
    state.MagicBurstMode = M{['description'] = 'MagicBurst Mode'}
	state.MagicBurstMode:options('None', 'Single')

	-- Ru'an	
	-- Reisenjima 
	-- -> in Mote-Globals
	
	-- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    -- Relic3
    set_lockstyle(2)
    -- AF3
    --set_lockstyle(26)

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard"}
    sets.precast.JA['Convert'] = {main="Murgleis",sub="Sacro Bulwark"}

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt", 
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +3",
        body="Atrophy Tabard +3",hands="Atrophy Gloves +3",
        legs="Atrophy Tights +3",feet="Vitiation Boots"}
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps 80%; RDM JT: 30%
        -- JP "Fast Cast Effect" 8/8
    sets.precast.FC = {
        ammo="Impatiens",
        head="Atrophy Chapeau +3",	    --16%
        neck="Loricate Torque +1",
        ear1="Loquacious Earring",      --2%
        ear2="Malignance Earring",
        body="Vitiation Tabard",	    --13%
		hands="Gendewitha Gages +1",    --8%
        ring1="Murky Ring",
        ring2="Kishar Ring",            --5%
        back=gear.sucellos_macc,
        waist="Witful Belt",
		legs="Ayanmo Cosciales +2",       --6%
		feet=gear.merlin_feet_fc,	    --10%
		}

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

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendicant's Earring",legs="Kaykaus Tights +1"})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {main="Pukulatmuj +1",sub="Sacro Bulwark"})
    sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Oshasha's Treatise",
        head="Vitiation Chapeau",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Ilabrat Ring",
        back=gear.sucellos_wsd,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Lethargy Houseaux"}
    
    sets.precast.WS.Proc = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Ayanmo Cosciales +2",feet=gear.chironic_feet_refresh}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
		--~73% MND
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Fotia Gorget", waist="Fotia Belt"})

        --80% DEX
	sets.precast.WS['Chant du Cygne'] = {ammo="Yetshila +1",
        head="Vitiation Chapeau",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Lethargy Sayon +3",hands="Nyame Gauntlets",ring1="Ilabrat Ring",ring2="Begrudging Ring",
        back=gear.sucellos_cdc,waist="Fotia Belt",legs="Vitiation Tights +3",feet="Thereoid Greaves"}
    
    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

        --50% STR / 50% MND
    sets.precast.WS['Savage Blade']= {ammo="Oshasha's Treatise",
        head="Vitiation Chapeau",neck="Republican Platinum Medal",ear1="Moonshade Earring",ear2="Regal Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Cornelia's Ring",ring2="Metamorph Ring +1",
        back=gear.sucellos_wsd ,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Lethargy Houseaux"}
    sets.precast.WS['Savage Blade']= {ammo="Oshasha's Treatise",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Regal Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Cornelia's Ring",ring2="Metamorph Ring +1",
        back=gear.sucellos_mab,waist="Cetl Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
    sets.precast.WS['Savage Blade'].Proc = sets.precast.WS.Proc

        --50% MND / 50% STR
    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    
        --70% MND / 30% STR
    sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

        --50% MND / 30% STR / Magical (pINT-mINT)*2
    sets.precast.WS['Sanguine Blade'] = {ammo="Sroda Tathlum",
        head="Pixie Hairpin +1",neck="Sibyl Scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Metamorph Ring +1",ring2="Archon Ring",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Vitiation Boots"}
--[[
    sets.precast.WS['Sanguine Blade'] = {ammo="Sroda Tathlum",
        head="Pixie Hairpin +1",neck="Sibyl Scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Metamorph Ring +1",ring2="Archon Ring",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Lethargy Fuseau",feet="Vitiation Boots"}
]]--
    sets.precast.WS['Seraph Blade'] = {ammo="Sroda Tathlum",
        head="Cath Palug Crown",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Cornelia's Ring",ring2="Metamorph Ring +1",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Vitiation Boots"}

		--40% DEX / 40% INT / Magical (pINT-mINT)/2 + 8 (32cap)
    sets.precast.WS['Aeolian Edge'] = {ammo="Sroda Tathlum",
        head="Nyame Helm",neck="Sibyl Scarf",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Cornelia's Ring",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Vitiation Boots"}

        --50% DEX
    sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +3",ear2="Loquacious Earring",
        body="Vitiation Tabard",hands="Leyline Gloves",
        waist="Embla Sash",legs="Kaykaus Tights +1",feet=gear.merlin_feet_fc}

	--Cure potency  41/50%(no tamaxchi)    |   Enmity - /50   |   Skill 0/500
    --[[]
    sets.midcast.Cure = { 
        ammo="Regal Gem",
        --main="Daybreak",                    --22%
        main="Maxentius",
        sub="Sors Shield",
        head=gear.vanya_head_skill,
		neck="Incanter's Torque",           
		ear1="Calamitous Earring",
		ear2="Mendicant's Earring",         --5%
        body="Kaykaus Bliaut +1",           --6%/4+2%/
        hands="Kaykaus Cuffs +1",           --11%/2%/-6
		ring1="Stikini Ring +1",            --
		ring2="Lebeche Ring",               --3%
        back=gear.sucellos_macc,             
		waist="Luminary Sash",
		legs="Atrophy Tights +3",
        feet=gear.vanya_feet_cp
    }
    ]]--
    sets.midcast.Cure = { 
        main="Nibiru Cudgel",
        sub="Sors Shield",
        ammo="Impatiens",
        head=gear.vanya_head_skill,
        body=gear.vanya_body_skill,
        hands=gear.vanya_hands_skill,
        legs="Atrophy Tights +3",
        feet=gear.vanya_feet_cp,
        neck="Warder's Charm +1",
        waist="Bishop's Sash",
        left_ear="Meili Earring",
        right_ear="Mendi. Earring",
        left_ring="Sirona's Ring",
        right_ring="Lebeche Ring",
        back=gear.sucellos_macc
    }

	sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Bishop's Sash"}
    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        ear1="Regal Earring",
        waist="Hachirin-no-Obi",back="Twilight Cape"
    }

    -- Skill 604/600+
    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj +1",           -- +11
        sub="Forfend +1",               -- +10
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",          -- +16
        neck="Incanter's Torque",       -- +10
        ear1="Mimir Earring",           -- +10
        --ear2="Andoaa Earring",          -- +5
        ear2="Lethargy Earring",        -- +5
        body="Vitiation Tabard",     -- +21
        hands="Vitiation Gloves",    -- +22
        ring1="Stikini Ring +1",        -- +8
        ring2="Stikini Ring",
        back=gear.ghostfyre,            -- +10/10
        waist="Olympus Sash",           -- +5
        legs="Atrophy Tights +3",       -- +21
        feet="Lethargy Houseaux"     -- +30
    }

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --10%
        body=gear.telchine_body_enh_dur,    --10%
        hands=gear.telchine_hands_enh_dur,  --10%
        waist="Embla Sash",                 --10%
        legs=gear.telchine_legs_enh_dur,    --10%
        feet=gear.telchine_feet_enh_dur     --10%
    }
    
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Sakpata's Sword",            
        sub="Ammurapi Shield",              --10%*
        head=gear.taeon_head_phalanx,       --3/9%
        body=gear.taeon_body_phalanx,       --3/8%
        hands=gear.taeon_hands_phalanx,     --3/4%
        legs=gear.taeon_legs_phalanx,       --3/5%
        back=gear.ghostfyre,                --20%
        feet=gear.taeon_feet_phalanx        --3/9%
    })
    sets.midcast['Phalanx II'] = set_combine(sets.midcast['Enhancing Magic'],{
        main=gear.colada_enhdur,            --4%
        sub="Ammurapi Shield",              --10%
        neck="Duelist's Torque +2",         --15/20%(aug)
        back=gear.ghostfyre,                --20%
    })

    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1",body="Atrophy Tabard +3",legs="Lethargy Fuseau"})
    sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {waist="Gishdubar Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1"})
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.GainSpell = set_combine(sets.midcast.EnhancingDuration,{
        hands="Vitiation Gloves",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        head="Vanya Hood",
        neck="Debilis Medallion",
        ear2="Meili Earring",
        body="Vitiation Tabard",
        hands="Nyame Gauntlets",
        ring1="Menelaus's Ring",ring2="Haoma's Ring",
        legs="Vanya Slops",
        back="Oretania's Cape +1",                       --5%
        feet="Vanya Clogs"                               --10%
    })
    sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna, {waist="Gishdubar Sash"})

    -- Pure MACC
    sets.midcast.PureMacc = {main="Murgleis",sub="Ammurapi Shield",ammo=empty,range="Ullr",
        head="Atrophy Chapeau +3",neck="Duelist's Torque +2",ear1="Regal Earring",ear2="Snotra Earring",
        body="Atrophy Tabard +3",hands="Lethargy Gantherots",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Acuity Belt +1",legs=gear.chironic_legs_macc,feet="Vitiation Boots"}
    
    sets.midcast.DurationMacc = set_combine( sets.midcast.PureMacc, {
        back=gear.sucellos_macc
    })

    -- Base Enfeebling
    sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Vitiation Chapeau",neck="Duelist's Torque +2",ear1="Regal Earring",ear2="Snotra Earring",
        body="Lethargy Sayon +3",hands="Lethargy Gantherots",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back=gear.sucellos_macc,waist="Obstinate Sash",legs=gear.chironic_legs_macc,feet="Vitiation Boots"}
        
    sets.midcast['Enfeebling Magic'] = {    
        main="Eletta Rod",
        sub="Sors Shield",
        ammo="Impatiens",
        head="Befouled Crown",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Aya. Cosciales +2",
        feet="Malignance Boots",
        neck="Sanctity Necklace",
        waist="Embla Sash",
        left_ear="Alabaster Earring",
        right_ear="Malignance Earring",
        left_ring="Murky Ring",
        right_ring="Defending Ring",
        back="Atheling Mantle"
}
    sets.midcast['Enfeebling Magic'].Resistant = {main="Murgleis",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Atrophy Chapeau +3",neck="Duelist's Torque +2",ear1="Regal Earring",ear2="Snotra Earring",
        body="Lethargy Sayon +3",hands="Lethargy Gantherots",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back=gear.sucellos_macc,waist="Acuity Belt +1",legs=gear.chironic_legs_macc,feet="Vitiation Boots"}

    -- MND Potency Enfeebles
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
        --main=gear.grio_enfeeble,
        --sub="Enki Strap",
        ammo="Regal Gem",
        ring1="Metamorph Ring +1",
        waist="Luminary Sash"
    })

    sets.midcast.MndEnfeebles.MaxMACC = set_combine(sets.midcast.MndEnfeebles,{
        ammo=empty,range="Ullr",
        body="Atrophy Tabard +3",
        waist="Acuity Belt +1" 
    })
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles,sets.midcast['Enfeebling Magic'].Resistant)

    -- INT Potency Enfeebles
    sets.midcast.IntEnfeebles =  set_combine(sets.midcast['Enfeebling Magic'], {
        waist="Acuity Belt +1"        
    })
    sets.midcast.IntEnfeebles.MaxMACC = set_combine(sets.midcast.IntEnfeebles,{
        ammo=empty,range="Ullr",
        body="Atrophy Tabard +3"
    })
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles,sets.midcast['Enfeebling Magic'].Resistant)

    -- Skill Potency Enfeebles
    -- 625 Frazzle III
    -- 610 Distract III
    sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main=gear.grio_enfeeble,
        head="Vitiation Chapeau",    --22   
        neck="Duelist's Torque +2",
        ear2="Vor Earring",             --10
        body="Atrophy Tabard +3",       --21
        --waist="Obstinate Sash",         
        waist="Rumination Sash",        --7
        legs=gear.chironic_legs_macc,   --18
        feet="Vitiation Boots"       --14
    })
    sets.midcast.SkillEnfeebles.MaxMACC = set_combine(sets.midcast.SkillEnfeebles,{body="Lethargy Sayon +3"})
    sets.midcast.SkillEnfeebles.Resistant = set_combine(sets.midcast.SkillEnfeebles,{
        main="Murgleis",
        sub="Ammurapi Shield",
    })

	-- Cant be resisted so go full potency
    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], {
        head="Vitiation Chapeau",
        body="Lethargy Sayon +3",
    })
	
    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Lethargy Chappel",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"
        --feet="Vitiation Boots"
    }
    
    sets.midcast['Elemental Magic'] = {
        main="Maxentius",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Malignance Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Jhakri Ring",ring2="Ayanmo Ring",
        back=gear.sucellos_mab,waist="Shinjutsu-no-Obi +1",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
        feet="Vitiation Boots"
    })

    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
        main="Murgleis",sub="Ammurapi Shield",ammo=empty, range="Ullr",
        head=empty,body="Twilight Cloak",
        ear1="Snotra Earring",
        ear2="Malignance Earring",
        ring2="Stikini Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        --feet="Vitiation Boots"
        feet="Lethargy Houseaux" 
    })

    sets.midcast['Dark Magic'] = {ammo="Regal Gem",
        head="Cath Palug Crown",neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Malignance Earring",
        body="Shango Robe",hands="Malignance Gloves",ring1="Evanescence Ring",ring2="Stikini Ring +1",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet=gear.merlin_feet_fc}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Malignance Earring",
        body=gear.merlin_body_aspir,hands=gear.merlin_hands_aspir,ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.sucellos_macc,waist="Fucho-no-obi",legs="Ayanmo Cosciales +2",feet=gear.merlin_feet_fc}


    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Flash = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Sapience Orb",
        head="Halitus Helm",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Cryptic Earring",
        body="Lethargy Sayon +3",hands="Lethargy Gantherots",ring1="Gelatinous Ring +1",ring2="Supershear Ring",
        back=gear.sucellos_stp,waist="Kasiri Belt",legs="Carmine Cuisses +1",feet="Nyame Sollerets"}

    -- Sets for special buff conditions on spells.


    sets.buff.ComposureOther = {
        head="Lethargy Chappel",
        body="Lethargy Sayon +3",
        hands="Atrophy Gloves +3",          --20%
        legs="Lethargy Fuseau",
        feet="Lethargy Houseaux"       
    }
	-- 40% magic burst gear
	-- 
    sets.magic_burst = { 
        main="Bunzi's Rod",sub="Ammurapi Shield",
        --head=gear.merlin_head_mbd,		-- 	8%	
        head="Ea Hat +1",		        --t2 7% / t1 7%	
        neck="Mizukage-no-Kubikazari", 	-- 	      t1 10%        
        body="Ea Houppelande +1",       --t2 9% / t1 9%
        hands="Amalric Gages +1", 		--t2 6%
		ring1="Freke Ring",			    
        ring2="Mujin Band",			    --t2 5%	
        legs="Ea Slops +1",             --t2 8% / t1 8%
		--feet=gear.merlin_feet_mbd       --  8%
        feet="Amalric Nails +1"
    }
    
    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = sets.idle
    

    -- Idle sets
    sets.idle = {main="Bolelabunga"
        ,sub="Archduke's Shield",ammo="Homiliary",
        head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Alabaster Earring",ear2="Eabani Earring",
        body="Atrophy Tabard +3",hands="Malignance Gloves",ring1="Murky Ring",ring2="Shneddick Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.idle.Town = {main="Maxentius",sub="Ammurapi Shield",ammo="Sroda Tathlum",
        head="Atrophy Chapeau +3",neck="Duelist's Torque +2",ear1="Alabaster Earring",ear2="Malignance Earring", 
        body="Atrophy Tabard +3",hands="Atrophy Gloves +3",ring1="Murky Ring",ring2="Shneddick Ring",
        back=gear.sucellos_mab,waist="Luminary Sash",legs="Atrophy Tights +1",feet="Atrophy Boots +3"}
    
    sets.idle.Weak = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Vitiation Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Lethargy Sayon +3",hands=gear.chironic_hands_refresh,ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.chironic_feet_refresh}

    sets.idle.DT = {main="Daybreak",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Vitiation Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Lethargy Sayon +3",hands="Lethargy Gantherots",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.idle.Turtle = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.idle.Refresh = {main="Bolelabunga"
        ,sub="Archduke's Shield",ammo="Homiliary",
        head="Vitiation Chapeau",neck="Warder's Charm +1",ear1="Alabaster Earring",ear2="Eabani Earring",
        body="Atrophy Tabard +3",hands="Malignance Gloves",ring1="Murky Ring",ring2="Shneddick Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
    -- Defense sets
    sets.defense.PDT = {main="Sakpata's Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_stp,waist="Flume Belt",legs="Ayanmo Cosciales +2",feet=gear.chironic_feet_refresh}

    -- MEVA + Annul set
    sets.defense.MDT = {main="Daybreak",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Archon Ring",ring2="Defending Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Alabaster Earring",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ayanmo Ring",ring2="Jhakri Ring",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.EnSpell = set_combine(sets.engaged,{hands="Ayanmo Manopolas +2"})

    sets.engaged.Acc = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Hetairoi Ring",
        back=gear.sucellos_,waist="Grunfeld Rope",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}

    sets.engaged.Defense = {
        head="Malignance Chapeau",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Defending Ring",
        back=gear.sucellos_stp,waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}

    sets.engaged.MagicalDef = set_combine(sets.engaged,{
        neck="Asperity Necklace",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring"
    })

    -- 0% Magic Haste
    sets.engaged.DW = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.DW.EnSpell = set_combine(sets.engaged.DW,{hands="Ayanmo Manopolas +2"})

    -- 10% Magic Haste
    sets.engaged.DW.LowHaste = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.DW.EnSpell.LowHaste = set_combine(sets.engaged.DW.LowHaste,{hands="Ayanmo Manopolas +2"})

    -- 15% Magic Haste
    sets.engaged.DW.MidHaste = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.DW.EnSpell.MidHaste = set_combine(sets.engaged.DW.MidHaste,{hands="Ayanmo Manopolas +2"})

    --30% Magic Haste
    sets.engaged.DW.HighHaste = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.DW.EnSpell.HighHaste = set_combine(sets.engaged.DW.HighHaste,{hands="Ayanmo Manopolas +2"})

    --47.5% Magic Haste
    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Telos Earring",ear2="Eabani Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Sailfi Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.DW.EnSpell.MaxHaste = set_combine(sets.engaged.DW.MaxHaste,{hands="Ayanmo Manopolas +2"})

    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Lissome Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Chirich Ring +1",
        back=gear.sucellos_stp,waist="Eschan Stone",legs="Malignance Tights",feet="Malignance Boots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell)
    checkblocking(spell)
end

function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        --equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
        equip(sets.midcast.CursnaSelf)
    end

    if spell.skill == 'Elemental Magic' and state.MagicBurst.value and spell.english ~= "Impact" then
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

function job_post_aftercast(spell, action, spellMap, eventArgs)

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
    update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Enfeebling Magic' then
        -- Spells with variable potencies, divided into dINT and dMND spells.
        if S{'Slow','Slow II','Paralyze','Paralyze II','Addle','Addle II',
             'Distract','Distract II'}:contains(spell.english) then
            return "MndEnfeebles"
        elseif S{'Blind','Blind II','Gravity','Gravity II'}:contains(spell.english) then
            return "IntEnfeebles"
        elseif S{'Poison II','Distract III','Frazzle III'}:contains(spell.english) then
            return "SkillEnfeebles"
        elseif S{'Frazzle','Frazzle II', 'Stun'}:contains(spell.english) then
            return "PureMacc"
        elseif S{'Sleep','Sleep II', 'Bind', 'Break'}:contains(spell.english) then
            return "DurationMacc"
        end
    elseif spell.skill == 'Enhancing Magic' then
        if S{'Refresh'}:contains(default_spell_map) then
            if spell.target.type == 'SELF' then
                if _settings.debug_mode then
                    add_to_chat(123,'--- RefreshSelf ---')
                end
                return "RefreshSelf"
            end
        elseif not S{'Erase','Phalanx','Stoneskin','Aquaveil','Temper','Temper II'}:contains(spell.english)
        and not S{'Regen','Refresh','BarElement','BarStatus','EnSpell','GainSpell','Teleport'}:contains(default_spell_map) then
            if _settings.debug_mode then
                add_to_chat(123,'--- FixedPotencyEnhancing ---')
            end 
            return "FixedPotencyEnhancing"
        end
    end
end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

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
function update_combat_form()
    --add_to_chat(123, player.equipment.sub)
    for key, value in ipairs({'strap','grip','shield','bulwark','forfend','empty'}) do
        if string.find(player.equipment.sub:lower(), value) then
            state.CombatForm:set('SW')
            if not midaction() then
                handle_equipping_gear(player.status)
            end
            return
        end
    end
    -- Dual wield
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_self_command(command)
    if command[1] == 'delve' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 6; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Dbaggins; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Phalanx II" Dbaggins; wait 4;input /ma "Gain-Int" <me>; wait 5; input /ma "Refresh III" Lilbaggins')
        add_to_chat(158,'< DELVE >')
    elseif command[1] == 'six' then
            send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 6; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Sixsixthree; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Phalanx II" Sixsixthree; wait 4;input /ma "Gain-Int" <me>; wait 5; input /ma "Refresh III" Sixsixthree')
            add_to_chat(158,'< SIX >')
    elseif command[1] == 'nni' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 6; input /ma "Phalanx" <me>; wait 4; input /ma "Ice Spikes" <me>; wait 4; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>')
        add_to_chat(158,'Neo Nyzul Isle')      
    elseif command[1] == 'divine' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 6; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Sixsixthree; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>; wait 5; input /ma "Phalanx II" Sixsixthree; wait 4;input /ma "Gain-Int" <me>; wait 5;input /ma "Temper II" <me>; wait 4;input /ma "Enthunder" <me>;wait 5;input /ma "Shell V" <me>; wait 5;input /ma "Shell V" Sixsixthree;wait 5;input /ma "Protect V" <me>;wait 5;input /ma "Protect V" Sixsixthree;')
        add_to_chat(158,'DIVINE')
    elseif command[1] == 'lilith' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 6; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Sixsixthree; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>; wait 5; input /ma "Phalanx II" Sixsixthree; wait 4;input /ma "Gain-Int" <me>; wait 5;')
        add_to_chat(158,'LILITH')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
     -- Default macro set/book: (set, book)
    if player.sub_job == 'BLM' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 4)
    else
        set_macro_page(1, 4)   
    end
end