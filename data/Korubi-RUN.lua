-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.    
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 2

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT', 'Status')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.Greatsword = M{['description']='Current Weapon', 'Aettir', 'Montante +1'}
    state.Charm = M(false, 'Charm Resistance')
    state.Knockback = M(false, 'Knockback')
    state.Death = M(false, "Death Resistance")
    state.CP = M(false, "Capacity Points Mode")

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}


    gear.ogma_tp = "Evasionist's Cape"
    gear.ogma_enmtiy= { name="Ogma's cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
    -- To Do --
    gear.ogma_parry = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.ogma_fc    = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.ogma_reso  = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.ogma_dimid = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    send_command('bind ^` input //gs c rune')
    send_command('bind !` input /ja "Vivacious Pulse" <me>')
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind !g gs c cycle Greatsword')
    send_command('bind @h gs c toggle Charm')
    send_command('bind @k gs c toggle Knockback')
    send_command('bind @d gs c toggle Death')
    send_command('bind !q input /ma "Temper" <me>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    select_default_macro_book()

end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^f11')
    send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @e')
    send_command('unbind @k')
    send_command('unbind @d')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')

    send_command('unbind @g')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.enmity = {
        ammo="Sapience Orb", --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9
        legs="Erilaz Leg Guards +1", --7
        feet="Erilaz Greaves +1",--6
        neck="Unmoving Collar +1", --10
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        ring1="Supershear Ring", --5
        ring2="Eihwaz Ring", --5
        back=gear.ogma_enmtiy, --4
        waist="Kasiri Belt", --3
        }

    sets.enmity.HP = set_combine(sets.enmity, {
        ear2="Odnowa Earring +1",
        ring1="Moonbeam Ring",
        back="Moonlight Cape",
        waist="Oneiros Belt",
        })

    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {body="Runeist's Coat +2", legs="Futhark Trousers +1", back="Ogma's Cape"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.enmity, {feet="Runeist's Bottes +2"})
    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {head="Futhark Bandeau +1"})
    sets.precast.JA['Liement'] = set_combine(sets.enmity, {body="Futhark Coat +1"})

    sets.precast.JA['Lunge'] = {
        ammo="Seething Bomblet +1",
        head=gear.Herc_MAB_head,
        body="Samnuha Coat",
        hands="Carmine Finger Gauntlets +1",
        legs=gear.Herc_MAB_legs,
        feet=gear.Herc_MAB_feet,
        neck="Baetyl Pendant",
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring +1",
        ring2="Fenrir Ring +1",
        back="Argocham. Mantle",
        waist="Eschan Stone",
        }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist's Mitons +2"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.enmity, {body="Futhark Coat +1"})
    sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {hands="Futhark Mitons"})

    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {
        head="Erilaz Galea +1",
        legs="Runeist Trousers +1",
        neck="Incanter's Torque",
        ear1="Beatific Earring",
        ring1="Globidonta Ring",
        waist="Bishop's Sash",
        back="Merciful Cape",
        })

    sets.precast.JA['One For All'] = set_combine(sets.enmity, {})
    sets.precast.JA['Provoke'] = sets.enmity

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Runeist's Bandeau +2",    --12
        body="Adhemar Jacket",          --8
        hands="Leyline Gloves",         --8
        legs="Ayanmo Cosciales +2",     --6
        feet="Carmine Greaves +1",      --8
        neck="Baetyl Pendant",          --4
        ear1="Loquacious Earring",      --2
        ear2="Etiolation Earring",      --1
        ring1="Kishar Ring",            --4
        ring2="Rahab Ring",             --2
        back=gear.RUN_FC_Cape,          --10
        waist="Rumination Sash",
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
        head="Runeist's Bandeau +2",
        body="Runeist's Coat +2",
        ear1="Odnowa Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonbeam Ring",
        waist="Oneiros Belt",
        })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +1",
        waist="Siegel Sash",
        })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ammo="Impatiens", ear2="Mendicant's Earring"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        body="Passion Jacket",
        neck="Magoraga Beads",
        ring1="Lebeche Ring",
        waist="Rumination Sash",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.herc_head_sbwsd,
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        feet=gear.herc_feet_ta,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.ogma_wsd,
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        body=gear.Adhemar_B_body,
        legs="Meghanada Chausses +2",
        ear2="Telos Earring",
        })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        head="Meghanada Visor +2",
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        waist="Grunfeld Rope",
        feet=gear.herc_feet_ta,
        ring1="Hetairoi Ring",
        ring2="Niqmaddu Ring",
        back=gear.ogma_wsd,
        })

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        head="Dampening Tam",
        hands="Adhemar Wristbands +1",
        legs="Meghanada Chausses +2",
        feet=gear.Herc_STP_feet,
        ear2="Telos Earring",
        })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
        ear1="Ishvara Earring",
        legs="Lustr. Subligar +1",
        feet=gear.herc_legs_sbwsd,
        neck="Caro Necklace",
        back=gear.ogma_wsd,
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
        ammo="Seething Bomblet +1",
        body=gear.Adhemar_B_body,
        legs="Samnuha Tights",
        feet=gear.Herc_STP_feet,
        ear2="Telos Earring",
        })

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        body=gear.Herc_WS_body,
        legs="Meghanada Chausses +2",
        feet="Meghanada Jambeaux +2",
        neck="Caro Necklace",
        ear1="Ishvara Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        waist="Grunfeld Rope",
        back=gear.ogma_wsd,
        })

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Seething Bomblet +1",
        head="Pixie Hairpin +1",
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        legs=gear.Herc_MAB_legs,
        feet=gear.Herc_MAB_feet,
        neck="Baetyl Pendant",
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        ring1="Archon Ring",
        ring2="Stikini Ring",
        back="Argocham. Mantle",
        waist="Eschan Stone",
        }

    sets.precast.WS['True Strike'] = sets.precast.WS['Resolution']

    sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        head=gear.Herc_MAB_head,
        ring1="Shiva Ring +1",
        ring2="Rahab Ring",
        })

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Fell Cleave'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Full Break'] = {
        ammo="Pemphredo Tathlum",
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Leyline Gloves",
        legs="Ayanmo Cosciales +2",
        feet="Ayanmo Gambieras +2",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Moonshade Earring",
        ring1="Ayanmo Ring",
        ring2="Rahab Ring",
        back=gear.ogma_wsd,
        waist="Eschan Stone",
        }

    sets.precast.WS['Shockwave'] = sets.precast.WS['Full Break']


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum", --10
        legs="Carmine Cuisses +1", --20
        ear1="Halasz Earring",
        ring1="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

    sets.midcast.Cure = {
        sub="Mensch Strap +1",
        ammo="Staunch Tathlum",
        head=gear.Herc_DT_head,
        body="Vrikodara Jupon", -- 13
        hands="Buremte Gloves", --(13)
        legs="Ayanmo Cosciales +2",
        feet="Skaoi Boots", --7
        neck="Phalaina Locket", -- 4(4)
        ear1="Roundel Earring", -- 5
        ear2="Mendicant's Earring", -- 5
        ring1="Lebeche Ring", -- 3
        ring2="Defending Ring",
        back="Solemnity Cape", -- 7
        waist="Gishdubar Sash", --(10)
        }

    sets.midcast['Enhancing Magic'] = {
        head="Carmine Mask +1",
        hands="Regal Gauntlets",
        legs="Futhark Trousers +1",
        neck="Incanter's Torque",
        ear1="AugmentingEarring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        back="Merciful Cape",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
        head="Erilaz Galea +1",
        legs="Futhark Trousers +1",
        })

    sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Pukulatmuj +1",
        sub="Pukulatmuj",
        head="Carmine Mask +1",
        body="Manasa Chasuble",
        hands="Runeist's Mitons +2",
        legs="Carmine Cuisses +1",
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Deacon Sword", --4
        sub="Chanter's Shield",
        ammo="Staunch Tathlum", --(11)
        head="Futhark Bandeau +1", --5
        body=gear.taeon_body_phalanx, --3(10)
        hands=gear.taeon_hands_phalanx, --3(8)
        legs=gear.taeon_legs_phalanx, --3(8)
        feet=gear.taeon_feet_phalanx, --3(10)
        ear1="Halasz Earring", --(5)
        ring1="Evanescence Ring", --(5)
        waist="Rumination Sash", --(10)
        })

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Runeist's Bandeau +2"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        ammo="Yamarang",
        legs="Runeist Trousers +1",
        neck="Incanter's Torque",
        ring1="Stikini Ring",
        ring2="Stikini Ring",
        waist="Bishop's Sash",
        }

    sets.midcast.Flash = sets.enmity
    sets.midcast.Foil = sets.enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        sub="Mensch Strap +1",
        ammo="Homiliary",
        head="Ayanmo Zucchetto +2",
        body="Runeist's Coat +2",
        hands="Regal Gauntlets",
        legs="Carmine Cuisses +1",
        feet="Erilaz Greaves +1",
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Genmei Earring",
        ring1="Vocane Ring",
        ring2="Defending Ring",
        back="Evasionist's Cape",
        waist="Flume Belt",
        }

    sets.idle.DT = {
        sub="Refined Grip +1", --3/3
        ammo="Staunch Tathlum", --3/3
        head=gear.Herc_DT_head, --3/3
        body="Runeist's Coat +2",
        hands="Turms Mittens +1",
        legs="Carmine Cuisses +1",
        feet="Erilaz Greaves +1", --5/0
        neck="Loricate Torque +1", --6/6
        ear1="Genmei Earring", --2/0
        ear1="Odnowa Earring +1", --0/2
        ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Evasionist's Cape", --7/4
        waist="Flume Belt", --4/0
        }

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Staunch Tathlum",
        head="Adhemar Bonnet",
        hands="Turms Mittens +1",
        feet="Regal Gauntlets",
        neck="Loricate Torque +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Moonbeam Ring",
        ring2="Defending Ring",
        back="Evasionist's Cape",
        })

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Charm = {
        neck="Unmoving Collar +1",
        ear2="Arete del Luna +1",
        ring1="Wuji Ring",
        back="Solemnity Cape",
        }

    sets.defense.Knockback = {back="Repulse Mantle"}
    sets.defense.Death = {body="Samnuha Coat", ring1="Warden's Ring", ring2="Eihwaz Ring"}

    sets.defense.PDT = {
        sub="Refined Grip +1", --3/3
        ammo="Staunch Tathlum", --3/3
        head="Adhemar Bonnet", --4/0
        body="Futhark Coat +1", --7/7
        hands="Ayanmo Manopolas +2",
        legs="Erilaz Leg Guards +1", --7/0
        feet="Regal Gauntlets",
        neck="Loricate Torque +1", --6/6
        ear1="Ethereal Earring",
        ear2="Odnowa Earring +1", --0/2
        ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.RUN_HP_Cape,
        waist="Flume Belt", --4/0
        }

    sets.defense.MDT = {
        sub="Irenic Strap +1", --0/5
        ammo="Staunch Tathlum", --3/3
        head=gear.Herc_DT_head, --3/3
        body="Runeist's Coat +2",
        hands=gear.Herc_DT_hands, --7/5
        legs="Erilaz Leg Guards +1", --7/0
        feet="Erilaz Greaves +1",--5/0
        neck="Warder's Charm",
        ear1="Ethereal Earring",
        ear2="Odnowa Earring +1", --0/2
        ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.RUN_FC_Cape, --10/0
        waist="Engraved Belt",
        }

    sets.defense.Status = {
        sub="Mensch Strap +1", --5/0
        ammo="Staunch Tathlum", --3/3
        head=gear.Herc_DT_head, --3/3
        body="Ayanmo Corazza +2", --6/6
        hands="Erilaz Gauntlets",
        legs="Runeist Trousers +1", --5/0
        feet="Regal Gauntlets",
        neck="Loricate Torque +1", --6/6
        ear1="Hearty Earring",
        ear2="Genmei Earring", --2/0
        ring1="Vocane Ring", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.RUN_FC_Cape, --10/0
        waist="Engraved Belt",
        }

    sets.defense.HP = {
        sub="Refined Grip +1", --3/3
        ammo="Staunch Tathlum", --3/3
        head="Adhemar Bonnet", --4/0
        body="Runeist's Coat +2",
        hands="Runeist's Mitons +2", --3/0
        legs="Erilaz Leg Guards +1", --7/0
        feet="Regal Gauntlets",
        neck="Loricate Torque +1", --6/6
        ear1="Odnowa Earring", --0/1
        ear2="Odnowa Earring +1", --0/2
        ring1="Moonbeam Ring", --5/5
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        waist="Flume Belt", --4/0
        }

    sets.defense.Parry = {
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +1",
        feet="Regal Gauntlets",
        back=gear.RUN_HP_Cape,
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        sub="Utu Grip",
        ammo="Yamarang",
        head="Dampening Tam",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet=gear.herc_feet_ta,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        ring1="Epona's Ring",
        ring2="Niqmaddu Ring",
        back="Evasionist's Cape",
        waist="Ioskeha Belt +1",
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head="Dampening Tam",
        neck="Combatant's Torque",
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ear2="Telos Earring",
        ring1="Regal Ring",
        feet=gear.Herc_STP_feet,
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Carmine Mask +1",
        body="Runeist's Coat +2",
        hands="Runeist's Mitons +2",
        legs="Carmine Cuisses +1",
        ear1="Cessance Earring",
        waist="Olseni Belt",
        })

    sets.engaged.STP = set_combine(sets.engaged, {
        feet="Carmine Greaves +1",
        ear2="Telos Earring",
        waist="Ioskeha Belt +1",
        })

    sets.engaged.Aftermath = {
        head="Ayanmo Zucchetto +2",
        body="Turms Harness",
        neck="Anu Torque",
        ear2="Telos Earring",
        ring1="Moonbeam Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {
        head="Adhemar Bonnet", --4/0
        body="Ayanmo Corazza +2", --6/6
        hands="Ayanmo Manopolas +2",
        legs="Meghanada Chausses +2",
        neck="Loricate Torque +1", --6/6
        ring1="Moonbeam Ring", --5/5
        ring2="Defending Ring", --10/10
        back=gear.ogma_tp, --10/0
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.Hybrid)

    sets.engaged.Aftermath.DT = {
        head="Ayanmo Zucchetto +2",
        body="Turms Harness",
        feet="Carmine Greaves +1",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Moonbeam Ring",
        ring2="Defending Ring",
        waist="Kentarch Belt +1",
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {ring1="Eshmun's Ring", ring2="Eshmun's Ring", waist="Gishdubar Sash"}

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.enmity.HP)
            else
                equip(sets.precast.FC.HP)
            end
        elseif spell.action_type == 'Ability' then
            equip(sets.enmity.HP)
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.PhysicalDefenseMode.value == 'HP' and spell.action_type == 'Magic' then
        eventArgs.handled = true
        equip(sets.enmity.HP)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.EnhancingDuration)
    end
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    --if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
    --    handle_equipping_gear(player.status)
    --    eventArgs.handled = true
    --end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        --send_command('wait '..rayke_duration..';input /p Rayke: OFF <call21>;')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        --send_command('wait '..gambit_duration..';input /p Gambit: OFF <call21>;')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
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
    if state.Charm.value == true then
        idleSet = set_combine(idleSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        idleSet = set_combine(idleSet, sets.defense.Death)
    end

    if state.Greatsword.current == 'Montante +1' then
        equip({main="Montante +1"})
    elseif state.Greatsword.current == 'Aettir' then
        equip({main="Aettir"})
    end

    --if state.CP.current == 'on' then
    --    equip(sets.CP)
    --    disable('back')
    --else
    --    enable('back')
    --end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
     if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Charm.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Death)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Charm.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Charm)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end
    if state.Death.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Death)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = '[ Melee'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '

    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Charm.value == true then
        msg = msg .. '[ Charm ]'
    end

    if state.Knockback.value == true then
        msg = msg .. '[ Knockback ]'
    end

    if state.Death.value == true then
        msg = msg .. '[ Death ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode ]'
    end

    msg = msg .. '[ *' .. state.Runes.current .. '* ]'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 13)
    else
        set_macro_page(1, 13)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end