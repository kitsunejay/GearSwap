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

    include('Mote-TreasureHunter')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal','EnSpell','Acc')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant','MaxPotency')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

	state.MagicBurst = M(false, 'Magic Burst')

	-- Ru'an	
	-- Reisenjima 
	-- -> in Mote-Globals
	
	-- Additional local binds
	send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    -- Relic3
    set_lockstyle(1)
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
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    sets.precast.JA['Convert'] = {main="Murgleis",sub="Genmei Shield"}

    sets.TreasureHunter = {
        head="White Rarab Cap +1",
        waist="Chaac Belt", 
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +3",
        body="Atrophy Tabard +3",hands="Atrophy Gloves +3",
        legs="Atrophy Tights +3",feet="Vitiation Boots +3"}
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps 80%; RDM JT: 30%
        -- JP "Fast Cast Effect" 8/8
    sets.precast.FC = {
        head="Atrophy Chapeau +3",	    --16%
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",      --1%
        ear2="Genmei Earring",
        body="Vitiation Tabard +3",	    --13%
		hands="Leyline Gloves", 	    --8%
		ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back=gear.sucellos_dw,
        waist="Flume Belt",
		legs="Ayanmo Cosciales +2",     --6%
		feet=gear.merlin_feet_fc,	    --10%
		}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendicant's Earring",legs="Kaykaus Tights +1",back="Pahtli Cape"})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {main="Pukulatmuj +1",sub="Genmei Shield"})
    sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Ayanmo Corazza +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Jhakri Ring",
        back=gear.sucellos_wsd,waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
		--~73% MND
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Fotia Gorget", waist="Fotia Belt"})

        --80% DEX
	sets.precast.WS['Chant du Cygne'] = {ammo="Yetshila +1",
        head="Vitiation Chapeau +3",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Ayanmo Corazza +2",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Begrudging Ring",
        back=gear.sucellos_cdc,waist="Fotia Belt",legs="Vitiation Tights +3",feet="Thereoid Greaves"}

        --50% STR / 50% MND
    sets.precast.WS['Savage Blade']= {ammo="Ginsen",
        head="Vitiation Chapeau +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Regal Earring",
        body="Vitiation Tabard +3",hands="Atrophy Gloves +3",ring1="Karieyh Ring +1",ring2="Rufescent Ring",
        back=gear.sucellos_wsd ,waist="Grunfeld Rope",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

        --50% MND / 50% STR
    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
        --70% MND / 30% STR
    sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

        --50% MND / 30% STR / Magical (pINT-mINT)*2
    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Archon Ring",
        back=gear.sucellos_mab,waist="Eschan Stone",legs="Amalric Slops +1",feet="Vitiation Boots +3"}

    sets.precast.WS['Seraph Blade'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Shiva Ring +1",
        back=gear.sucellos_mab,waist="Eschan Stone",legs="Amalric Slops +1",feet="Vitiation Boots +3"}

		--40% DEX / 40% INT / Magical (pINT-mINT)/2 + 8 (32cap)
	sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Freke Ring",ring2="Shiva Ring +1",
        back=gear.sucellos_mab,waist="Eschan Stone",legs="Amalric Slops +1",feet="Vitiation Boots +3"}

        --50% DEX
    sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +3",ear2="Loquacious Earring",
        body="Vitiation Tabard +3",hands="Leyline Gloves",
        back="Swith Cape +1",waist="Witful Belt",legs="Kaykaus Tights +1",feet=gear.merlin_feet_fc}

	--Cure potency  41/50%(no tamaxchi)    |   Enmity - /50   |   Skill 0/500
    sets.midcast.Cure = { ammo="Regal Gem",
        main="Daybreak",                    --22%
        sub="Genmei Shield",
        head="Kaykaus Mitra +1",            --11%/2%/-6
		neck="Incanter's Torque",           
		ear1="Calamitous Earring",
		ear2="Mendicant's Earring",         --5%
        body="Kaykaus Bliaut +1",           --6%/4+2%/
        hands="Kaykaus Cuffs +1",           --11%/2%/-6
		ring1="Janniston Ring",             --5% CPII
		ring2="Lebeche Ring",               --3%
        back=gear.sucellos_macc,             
		waist="Luminary Sash",
		legs="Kaykaus Tights +1",           --11%/2%/-6
        --legs="Atrophy Tights +3",           --12%
        feet="Vanya Clogs"                  --5%
    }
    
	sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Gishdubar Sash"}
    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        ear1="Regal Earring",
        waist="Hachirin-no-Obi",back="Twilight Cape"
    }

    -- Skill 604/600+
    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj +1",           -- +11
        --sub="Ammurapi Shield",
        sub="Pukulatmuj",               -- +10
        ammo="Staunch Tathlum",
        head="Befouled Crown",          -- +16
        neck="Incanter's Torque",       -- +10
        ear1="Augmenting Earring",      -- +3
        ear2="Andoaa Earring",          -- +5
        body="Vitiation Tabard +3",     -- +21
        hands="Vitiation Gloves +3",    -- +22
        ring1="Stikini Ring",           -- +5
        ring2="Defending Ring",
        back=gear.ghostfyre_enh,        -- +9/10
        waist="Olympus Sash",           -- +5
        legs="Atrophy Tights +3",       -- +21
        feet="Lethargy Houseaux +1"     -- +20
    }

    sets.midcast.EnhancingDuration = {
        main=gear.colada_enhdur,            --4%
        sub="Ammurapi Shield",              --10%
        head=gear.telchine_head_enh_dur,    --10%(aug)
        neck="Duelist's Torque +1",         --15/20%(aug)
        body="Vitiation Tabard +3",         --15%
        hands="Atrophy Gloves +3",          --20%
        legs=gear.telchine_legs_enh_dur,    --10%(aug)
        back=gear.ghostfyre_dur,            --19/20%*
        feet="Lethargy Houseaux +1"         --30%
    }
    
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Pukulatmuj +1",            
        sub="Ammurapi Shield",              --10%*
        head=gear.taeon_head_phalanx,       --3/9%
        body=gear.taeon_body_phalanx,       --3/8%
        hands=gear.taeon_hands_phalanx,     --3/4%
        legs=gear.taeon_legs_phalanx,       --3/5%
        back=gear.ghostfyre_dur,
        feet=gear.taeon_feet_phalanx        --3/9%
    })
    sets.midcast['Phalanx II'] = set_combine(sets.midcast['Enhancing Magic'],{
        main=gear.colada_enhdur,            --4%
        sub="Ammurapi Shield",              --10%
        neck="Duelist's Torque +1",         --15/20%(aug)
        back=gear.ghostfyre_dur,            --19/20%*
    })

    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif",body="Atrophy Tabard +3",legs="Lethargy Fuseau +1"})
    sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.GainSpell = set_combine(sets.midcast.EnhancingDuration,{
        hands="Vitiation Gloves +3",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        ring1="Sirona's Ring",ring2="Ephedra Ring",
        back="Oretania's Cape +1",                       --5%
        feet="Gendewitha Galoshes +1"                   --10%
    })
    sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna, {waist="Gishdubar Sash"})

    -- Base Enfeebling
    sets.midcast['Enfeebling Magic'] = {main="Murgleis",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Vitiation Chapeau +3",neck="Duelist's Torque +1",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Atrophy Tabard +3",hands="Kaykaus Cuffs +1",ring1="Kishar Ring",ring2="Stikini Ring",
        back=gear.sucellos_macc,waist="Luminary Sash",legs=gear.chironic_legs_macc,feet="Vitiation Boots +3"}

    -- MND Potency Enfeebles
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
        main=gear.grio_enfeeble,
        sub="Enki Strap",
        ammo="Regal Gem",
        waist="Luminary Sash"
    })

    sets.midcast.MndEnfeebles.MaxPotency = set_combine(sets.midcast.MndEnfeebles,{body="Lethargy Sayon +1",})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles,{
        main="Murgleis",
        sub="Ammurapi Shield",
    })

    -- INT Potency Enfeebles
    sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles
    sets.midcast.IntEnfeebles.MaxPotency = set_combine(sets.midcast.MndEnfeebles,{body="Lethargy Sayon +1",})
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles,{
        main="Murgleis",
        sub="Ammurapi Shield",
    })

    -- Skill Potency Enfeebles
    sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main=gear.grio_enfeeble,
        sub="Mephitis Grip",
        head="Vitiation Chapeau +3",    --22   
        --neck="Incanter's Torque",       --10
        neck="Duelist's Torque +1",
        ear2="Regal Earring",
        body="Atrophy Tabard +3",       --21
        hands="Kaykaus Cuffs +1", --
        waist="Rumination Sash",        --10
        legs=gear.chironic_legs_macc,         --18
        feet="Vitiation Boots +3"       --14
    })
    sets.midcast.SkillEnfeebles.MaxPotency = set_combine(sets.midcast.SkillEnfeebles,{body="Lethargy Sayon +1",})
    sets.midcast.SkillEnfeebles.Resistant = set_combine(sets.midcast.SkillEnfeebles,{
        main="Murgleis",
        sub="Ammurapi Shield",
    })

	-- Cant be resisted so go full potency
    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], {
        head="Vitiation Chapeau +3",
        body="Lethargy Sayon +1",
    })
    --sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +3"})
	--sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Duelist's Tights +2"})
	--sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Duelist's Tights +2"})
    --sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitiation Boots"})
	
    sets.midcast['Elemental Magic'] = {
        --main="Maxentius",sub="Ammurapi Shield",
        main="Raetic Staff +1",sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head=gear.merlin_head_mbd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
        back=gear.sucellos_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"
        --feet="Vitiation Boots +3"
    }
    

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
        ear1="Hecate's Earring",
        waist="Eschan Stone"
    })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {ammo="Regal Gem",
        head="Jhakri Coronal +2",neck="Erra Pendant",ear1="Hermetic Earring",ear2="Gwati Earring",
        body="Shango Robe",hands="Jhakri Cuffs +2",ring1="Jhakri Ring",ring2="Evanescence Ring",
        back=gear.sucellos_macc,waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Dignitary's Earring",
        body=gear.merlin_body_aspir,hands=gear.merlinic_hands_aspir,ring1="Archon Ring",ring2="Evanescence Ring",
        back=gear.sucellos_macc,waist="Fucho-no-obi",legs="Jhakri Slops +2",feet=gear.merlin_feet_aspir}


    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.


    sets.buff.ComposureOther = {
        head="Lethargy Chappel",
        body="Lethargy Sayon +1",
        hands="Atrophy Gloves +3",          --20%
        legs="Lethargy Fuseau +1",
        feet="Lethargy Houseaux +1"       
    }
	-- 40% magic burst gear
	-- 
    sets.magic_burst = { 
        --head=gear.merlin_head_mbd,		-- 	8%	
        head="Ea Hat +1",		        --t2 7% / t1 7%	
        neck="Mizukage-no-Kubikazari", 	-- 	      t1 10%        
        body="Ea Houppelande +1",       --t2 9% / t1 9%
        hands="Amalric Gages +1", 		--t2 6%
		ring1="Freke Ring",			    
        ring2="Mujin Band",			    --t2 5%	
        legs="Ea Slops +1",             --t2 8% / t1 8%
		feet=gear.merlin_feet_mbd       --  8%
    }
    
    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = sets.idle
    

    -- Idle sets
    sets.idle = {main="Daybreak",sub="Genmei Shield",ammo="Homiliary",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Atrophy Tabard +3",hands=gear.chironic_hands_refresh,ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_dw,waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.chironic_feet_refresh}

    sets.idle.Town = {main="Murgleis",sub="Ammurapi Shield",ammo="Regal Gem",
        head="Vitiation Chapeau +3",neck="Duelist's Torque +1",ear1="Malignance Earring",ear2="Regal Earring", 
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Freke Ring",ring2="Defending Ring",
        back=gear.sucellos_mab,waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}
    
    sets.idle.Weak = {main="Daybreak",sub="Beatific Shield +1",ammo="Homiliary",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Malignance Tabard",hands=gear.chironic_hands_refresh,ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_dw,waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.chironic_feet_refresh}

    sets.idle.DT = {main="Mafic Cudgel",sub="Beatific Shield +1",ammo="Homiliary",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Malignance Tabard",hands=gear.chironic_hands_refresh,ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_dw,waist="Flume Belt",legs="Vitiation Tights +3",feet=gear.chironic_feet_refresh}

    sets.idle.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Homiliary",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back="Engulfer Cape",waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}
    
    
    -- Defense sets
    sets.defense.PDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.sucellos_dw,waist="Flume Belt",legs="Vitiation Tights +3",feet=gear.chironic_feet_refresh}

    -- MEVA + Annul set * needs Titan Club for 50 PDT
    sets.defense.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum",
        head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Archon Ring",ring2="Defending Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Vitiation Tights +3",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Hetairoi Ring",
        back=gear.sucellos_cdc,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.engaged.EnSpell = set_combine(sets.engaged,{hands="Ayanmo Manopolas +2"})

    sets.engaged.Acc = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Lissome Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Ilabrat Ring",ring2="Jhakri Ring",
        back=gear.sucellos_dw,waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.engaged.Defense = {
        head="Atrophy Chapeau +3",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
        body="Malignance Tabard",hands="Ayanmo Manopolas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Xucau Mantle",waist="Eschan Stone",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}

    sets.engaged.MagicalDef = set_combine(sets.engaged,{
        neck="Loricate Torque +1",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring"
    })

    -- 0% Magic Haste
    sets.engaged.DW = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back=gear.sucellos_dw,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.taeon_feet_dw}
    
    sets.engaged.DW.EnSpell = set_combine(sets.engaged.DW,{
        head=gear.taeon_head_ta,
        hands="Ayanmo Manopolas +2"
    })

    -- 10% Magic Haste
    sets.engaged.DW.LowHaste = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Ayanmo Corazza +2",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back=gear.sucellos_dw,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.taeon_feet_dw}

    sets.engaged.DW.EnSpell.LowHaste = set_combine(sets.engaged.DW.LowHaste,{
            head=gear.taeon_head_ta,
            hands="Ayanmo Manopolas +2"
    })

    -- 15% Magic Haste
    sets.engaged.DW.MidHaste = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Ayanmo Corazza +2",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back=gear.sucellos_dw,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.taeon_feet_dw}
    
    sets.engaged.DW.EnSpell.MidHaste = set_combine(sets.engaged.DW.MidHaste,{
            head=gear.taeon_head_ta,
            hands="Ayanmo Manopolas +2"
    })

    --30% Magic Haste
    sets.engaged.DW.HighHaste = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Ayanmo Corazza +2",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Hetairoi Ring",
        back=gear.sucellos_dw,waist="Reiki Yotai",legs=gear.taeon_legs_ta,feet=gear.taeon_feet_dw}
    
    sets.engaged.DW.EnSpell.HighHaste = set_combine(sets.engaged.DW.HighHaste,{
        head=gear.taeon_head_ta,
        hands="Ayanmo Manopolas +2"
    })

    --47.5% Magic Haste
    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Anu Torque",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Ayanmo Corazza +2",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Hetairoi Ring",
        back=gear.sucellos_dw,waist="Windbuffet Belt +1",legs=gear.taeon_legs_ta,feet="Carmine Greaves +1"}

    sets.engaged.DW.EnSpell.MaxHaste = set_combine(sets.engaged.DW.MaxHaste,{
        head=gear.taeon_head_ta,
        hands="Ayanmo Manopolas +2"
    })

    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Lissome Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
        body="Ayanmo Corazza +2",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Jhakri Ring",
        back=gear.sucellos_dw,waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)

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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Enfeebling Magic' then
        -- Spells with variable potencies, divided into dINT and dMND spells.
        if S{'Slow','Slow II','Paralyze','Paralyze II','Addle','Addle II',
             'Distract','Distract II','Frazzle'}:contains(spell.english) then
            return "MndEnfeebles"
        elseif S{'Blind','Blind II','Gravity','Gravity II'}:contains(spell.english) then
            return "IntEnfeebles"
        elseif S{'Poison II','Distract III','Frazzle III'}:contains(spell.english) then
            return "SkillEnfeebles"
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
function job_self_command(command)
    if command[1] == 'delve' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 5; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Dbaggins; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>; wait 5; input /ma "Phalanx II" Dbaggins; wait 4;input /ma "Gain-Int" <me>')
        add_to_chat(158,'DELVE')
    elseif command[1] == 'nni' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 5; input /ma "Phalanx" <me>; wait 4; input /ma "Ice Spikes" <me>; wait 4; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>')
        add_to_chat(158,'Neo Nyzul Isle')      
    elseif command[1] == 'divine' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 5; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Sixsixthree; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>; wait 5; input /ma "Phalanx II" Sixsixthree; wait 4;input /ma "Gain-Int" <me>; wait 5;input /ma "Temper II" <me>; wait 4;input /ma "Enthunder" <me>')
        add_to_chat(158,'DIVINE')
    elseif command[1] == 'lilith' then
        send_command('input /ja "Composure" <me>; wait 1; input /ma "Haste II" <me>; wait 4; input /ma "Refresh III" <me>; wait 5; input /ma "Phalanx" <me>; wait 4; input /ma "Haste II" Sixsixthree; wait 5; input /ma "Aquaveil" <me>; wait 5; input /ma "Stoneskin" <me>; wait 5; input /ma "Phalanx II" Sixsixthree; wait 4;input /ma "Gain-Int" <me>; wait 5;')
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