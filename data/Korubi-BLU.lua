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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.Stun = S{'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'White Wind','Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    state.DW = M(true, 'Dual Wield')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
    send_command('bind !d gs c toggle DW')

    update_combat_form()
    select_default_macro_book()

    set_lockstyle(16)

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind !d')

end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {feet="Mavi Basmak +2"}
    sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    sets.buff.Enchainment = {body="Jhakri Robe +2"}
    sets.buff.Efflux = {legs="Mavi Tayt +2"}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}

    -- Fast cast sets for spells
        -- Fast Cast caps at 80%; BLU JT: 0%
        --      JP Bonus:
        --      28/80%
    sets.precast.FC = {
        ammo="Sapience Orb",
        head="Amalric Coif",        --10%
        ear1="Etiolation Earring",  --1%
        ear2="Loquacious Earring",  --2%
        body="Adhemar Jacket",      --7%
        neck="Baetyl Pendant",      --4%
        hands="Leyline Gloves",     --8%
        ring1="Defending Ring",
        ring2="Kishar Ring",
        back="Solemnity Cape",
        waist="Ninurta's Sash",
        legs="Psycloth Lappas",     --7%
        feet="Carmine Greaves +1"   --8%
    }
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Ayanmo Corazza +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Begrudging Ring",
        back=gear.rosmertas_cdc,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herc_feet_ta}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {legs="Jhakri Slops +2",back="Aurist's Cape",hands="Jhakri Cuffs +2"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS)

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Izdubar Mantle",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
        
        --80% DEX
	sets.precast.WS['Chant du Cygne'] = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",
        body="Abnoba Kaftan",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Begrudging Ring",
        back=gear.rosmertas_cdc,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herc_feet_cchance}
    
        --50% STR / 50% MND
    sets.precast.WS['Savage Blade'] = {ammo="Ginsen",
        head=gear.herc_head_sbwsd,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Assimilator's Jubbah +2",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Karieyh Ring +1",
        back=gear.rosmertas_wsd,waist="Sailfi Belt +1",legs=gear.herc_legs_sbwsd,feet=gear.herc_feet_ta}

        --70% MND / 30% STR
    sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Amalric Coif",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",
        back="Swith Cape +1",waist="Ninurta's Sash",legs="Carmine Cuisses +1",feet="Medium's Sabots"}
    
    sets.midcast['Enhancing Magic'] = {
        head=gear.telchine_head_enh_dur,    --10%(aug)
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",               -- +5
        body=gear.telchine_body_enh_dur,    --8%(aug) // max 10%
        hands=gear.telchine_hands_enh_dur,  --1%(aug)
        ring1="Stikini Ring",
        ring2="Stikini Ring +1",
        waist="Olympus Sash",
        back="Merciful Cape",
        legs=gear.telchine_legs_enh_dur,
        feet=gear.telchine_feet_enh_dur          
    }

    sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif",waist="Gishdubar Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif"})

    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Cure = {
        neck="Incanter's Torque",       
        ear1="Calamitous Earring",
        ear2="Mendicant's Earring",         --5%
        hands="Telchine Gloves",            --10%
        ring1="Lebeche Ring",               --2%
        ring2="Sirona's Ring",
        back="Solemnity Cape",              --7%
        waist="Luminary Sash",
        legs="Carmine Cuisses +1",        
        feet="Medium's Sabots"             --12%
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        head=gear.taeon_head_phalanx,
        body=gear.taeon_body_phalanx,
        hands=gear.taeon_hands_phalanx,
        legs=gear.taeon_legs_phalanx,
        back="Perimede Cape",
        feet=gear.taeon_feet_phalanx
    })

    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Apate Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical)

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=gear.rosmertas_mab,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical)
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Incanter's Torque",ear1="Regal Earring",ear2="Hermetic Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring +1",
        back=gear.rosmertas_mab,legs="Jhakri Slops +2",waist="Eschan Stone",feet="Jhakri Pigaches +2",}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Pemphredo Tathlum",
        head="Ayanmo Zucchetto +2",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Adhemar Jacket +1",hands="Ayanmo Manopolas +2",ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Xucau Mantle",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Adhemar Jacket +1",hands="Telchine Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
        back="Pahtli Cape",waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Medium's Sabots"}

    sets.midcast['Blue Magic'].Healing = {
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Odnowa Earring",ear2="Odnowa Earring +1",
        body="Adhemar Jacket +1",hands="Telchine Gloves",ring1="Defending Ring",ring2="Lebeche Ring",
        back="Pahtli Cape",legs="Carmine Cuisses +1",feet="Medium's Sabots"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",
        body="Assimilator's Jubbah",
        back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Assimilator's Bazubands +1"}
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Amalric Doublet +1",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.rosmertas_tp,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.Town = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
        body="Amalric Doublet +1",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.rosmertas_tp,waist="Sacro Cord",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Xucau Mantle",waist="Eschan Stone",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Xucau Mantle",waist="Eschan Stone",legs="Malignance Tights",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Ayanmo Corazza +2",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta }

    sets.engaged.Acc = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Telos Earring",
        body="Ayanmo Corazza +2",hands="Jhakri Cuffs +2",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Eschan Stone",legs="Jhakri Slops +2",feet=gear.herc_feet_ta}

    sets.engaged.Refresh = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Jhakri Robe +2",hands="Assimilator's Bazubands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta}

    sets.engaged.DW = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta}


    -- 11% DW
    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta}

    -- 20% DW
    sets.engaged.DW.HighHaste = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.herc_feet_ta}

    -- 31% DW
    sets.engaged.DW.MidHaste = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.taeon_feet_dw}

    -- 42% DW
    sets.engaged.DW.LowHaste = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet=gear.herc_feet_ta}

    sets.engaged.DW.Acc = {ammo="kik Feather",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epona's Ring",ring2="Petrov Ring",
        back=gear.rosmertas_tp,waist="Eschan Stone",legs="Samnuha Tights",feet=gear.herc_feet_ta}

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    sets.self_healing = {waist="Gishdubar Sash"}

    sets.precast.FC['Trust'] = sets.engaged
    sets.midcast['Trust'] = sets.engaged
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
            msg = msg .. ' ' .. v .. ''
        end
    end

    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
end

