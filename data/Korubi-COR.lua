-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')

    -- auto-inventory swaps
    include('organizer-lib')
    
    --	Sel
    --include('Sel-Include.lua')
    --include('Sel-Display.lua')

end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    --init_job_states({"MagicBurst"},{"CastingMode","IdleMode"})

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    -- Organizer items

    organizer_items = {
        echos="Echo Drops",
        shihei="Shihei",
        remedy="Remedy",
        sushi="Sublime Sushi",
        anarchy="Anarchy +2",
    }

    state.OffenseMode:options('Ranged', 'Melee', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Enmity', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Regen', 'Refresh', 'Regain')
    --state.DefenseMode:options('PDT', 'Reraise')


    gear.RAbullet = "Chrono Bullet"
    --gear.RAbullet = "Divine Bullet"
    
    gear.WSbullet = "Chrono Bullet"

    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

    state.WeaponLock = M(false, 'Weapon Lock')
    state.Gun = M{['description']='Current Gun','Death Penalty','Fomalhaut','Anarchy +2','Armageddon'}
    state.QuickDraw = M{['description']='QuickDraw','STP','ElementalBonus'}
    state.AttackCap = M(false, 'Attack Cap Set')

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    send_command('bind !g gs c cycle Gun')
    send_command('bind !q gs c cycle QuickDraw')
    send_command('bind !w gs c toggle WeaponLock')
    send_command('bind !b gs c toggle AttackCap')
    select_default_macro_book()

    set_lockstyle(27)

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !g')
    send_command('unbind !q')
    send_command('unbind !w ')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    -- PR set
    sets.precast.CorsairRoll = {
        range="Compensator",
        head="Lanun Tricorne +1",
        neck="Regal Necklace",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        body="Malignance Tabard",
        hands="Chasseur's Gants +1",
        legs="Desultor Tassets",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=gear.camulus_tp
    }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Mummu Bonnet +2",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",
        feet="Meghanada Jambeaux +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Herculean Helm",
        neck="Baetyl Pendant",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        body="Adhemar Jacket",
        hands="Leyline Gloves",
        ring2="Kishar Ring",
        feet="Carmine Greaves +1"
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Snapshot: 70% Cap (all sources)
    --      48/70   Snapshot
    --      29/??   Rapid Shot     

    --      5/5%  100JP
    --      5/5%  1200JP 

    --      (Flurry2 = 30%)
    --      (Flurry  ~ 15%)

    -- 0% // 60 to cap
    sets.precast.RA = {ammo=gear.RAbullet,
        head=gear.taeon_head_snap,           -- 10%
        --body="Laksamana's Frac +3",          -- 18% Rapid Shot
        body="Oshosi Vest +1",               -- 14% 
        hands="Carmine Finger Gauntlets +1", -- 8% // 11% Rapid Shot
        back=gear.camulus_snap,              -- 10%
        waist="Yemaya Belt",                 -- 5%  Rapid Shot
        legs="Adhemar Kecks +1",             -- 10% // 13% Rapid Shot
        feet="Meghanada Jambeaux +2"         -- 10%
    }
    
    -- 15% // 45 to cap
    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksamana's Frac +3",          -- 18% Rapid Shot
        waist="Yemaya Belt",                 -- 5%  Rapid Shot
        legs="Adhemar Kecks +1",             -- 10% // 13% Rapid Shot
        }) 

    -- 30% // 30 to cap
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        head="Chass. Tricorne +1",          -- 14% Rapid Shot
        waist="Impulse Belt"                -- 3%  
        })
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Dingir Ring",ring2="Apate Ring",
        back=gear.camulus_wsd,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Meghanada Jambeaux +2"}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- 73~85% AGI
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Laksamana's Frac +3",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_wsd,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Lanun Bottes +3"}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Moonshade Earring",
        body="Laksamana's Frac +3",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_wsd,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Meghanada Jambeaux +2"}

    -- 60% AGI // Magical
    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hermetic Earring",
        body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs=gear.herc_legs_mabwsd,feet="Lanun Bottes +3"}
    
    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        ear2="Moonshade Earring",
        ring2="Archon Ring",
    })

    sets.precast.WS['Savage Blade'] = {
        head=gear.herc_head_sbwsd,neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Laksamana's Frac +3",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_savageb,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Lanun Bottes +3"}

    sets.precast.WS['Evisceration'] = {
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",
        body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Regal Ring",ring2="Begrudging Ring",
        back=gear.camulus_savageb,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herc_feet_cchance}

    sets.precast.WS['Exenterator'] = {
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Laksamana's Frac +3",hands="Meghanada Gloves +2",ring1="Apate Ring",ring2="Petrov Ring",
        back=gear.camulus_wsd,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Meghanada Jambeaux +2"}

    sets.precast.WS['Requiescat'] = {        
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Telos Earring",ear2="Moonshade Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Apate Ring",ring2="Rufescent Ring",
        back=gear.camulus_wsd,waist="Fotia Belt",legs="Meghanada Chausses +2",feet="Meghanada Jambeaux +2"}

    sets.precast.WS['Aeolian Edge'] = {
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs=gear.herc_legs_mabwsd,feet="Lanun Bottes +3"}

    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Herculean Helm",
        neck="Loricate Torque +1",
        body="Adhemar Jacket",hands="Leyline Gloves",
        feet="Carmine Greaves +1"}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.precast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hermetic Earring",
        body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Stikini Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs=gear.herc_legs_mabwsd,feet="Chasseur's Bottes +1"}

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hermetic Earring",
        body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2="Stikini Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs=gear.herc_legs_mabwsd,feet="Chasseur's Bottes +1"}

    sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
        head=gear.herc_head_mabwsd,neck="Sanctity Necklace",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Lanun Frac +3",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Stikini Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs="Malignance Tights",feet="Lanun Bottes +3"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Laksamana's Tricorne +2",neck="Sanctity Necklace",ear1="Dignitary's Earring",ear2="Gwati Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Stikini Ring +1",
        back=gear.camulus_mwsd,waist="Eschan Stone",legs="Malignance Tights",feet="Laksamana's Boots +3"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    sets.TripleShot = {
        head="Oshosi Mask +1",      --5
        body="Chasseur's Frac +1",  --12
        hands="Lanun Gants +3",
        legs="Oshosi Trousers +1",   --6
        feet="Oshosi Leggings +1"    --3
    }

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=gear.camulus_tp,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
    
    sets.midcast.Enmity = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Beyla Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=gear.camulus_tp,waist="Yemaya Belt",legs="Malignance Tights",feet="Oshosi Leggings +1"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=gear.camulus_tp,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}

    -- Sets to return to when not performing an action.    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_da,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.Regen = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Genmei Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_da,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Meghanada Jambeaux +2"}

    sets.idle.Refresh = {ammo=gear.RAbullet,
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Mekosuchinae Harness",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_dw,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
    
    sets.idle.Regain = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_snap,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.Town = {ranged=state.Gun.current,ammo=gear.RAbullet,
        head="Oshosi Mask +1",neck="Regal Necklace",ear1="Enervating Earring",ear2="Telos Earring",
        body="Oshosi Vest +1",hands="Lanun Gants +3",ring1="Dingir Ring",ring2="Karieyh Ring +1",
        back=gear.camulus_dw,waist="Yemaya Belt",legs="Carmine Cuisses +1",feet="Oshosi Leggings +1"}
    
    -- Defense sets
    sets.defense.PDT = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_snap,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_snap,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    --   sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.DefenseMode][classes.CustomMeleeGroups (any number)]

    sets.engaged.Hybrid = {
        --neck="Loricate Torque +1", --6/6
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring", --10/10
        feet="Malignance Boots"
    }

    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_da,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta}
    
    sets.engaged.Melee.DT = set_combine(sets.engaged.Melee, sets.engaged.Hybrid)
    sets.engaged.Acc = {
        ear1="Cessance Earring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        legs="Meghanada Chausses +2"
    }
    sets.engaged.DW = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_dw,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet=gear.herc_feet_ta}

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)

    sets.engaged.DW.Melee = {ammo=gear.RAbullet,
        head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_dw,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet=gear.herc_feet_ta}
    
    sets.engaged.DW.Melee.DT = set_combine(sets.engaged.DW.Melee, sets.engaged.Hybrid)
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW.Melee, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    -- 11% DW
    sets.engaged.DW.Melee.MaxHaste = {ammo=gear.RAbullet,
        head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_da,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herc_feet_ta}
    
    sets.engaged.DW.Melee.DT.MaxHaste = set_combine(sets.engaged.DW.Melee.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.DW.Melee.MaxHaste, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)


    -- 31% DW
    sets.engaged.DW.Melee.HighHaste = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_da,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.taeon_feet_dw}

    sets.engaged.DW.Melee.DT.HighHaste = set_combine(sets.engaged.DW.Melee.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.HighHaste = set_combine(sets.engaged.DW.Melee.HighHaste, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    -- 42% DW
    sets.engaged.DW.Melee.MidHaste = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_da,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.taeon_feet_dw}

    sets.engaged.DW.Melee.DT.MidHaste = set_combine(sets.engaged.DW.Melee.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.MidHaste = set_combine(sets.engaged.DW.Melee.MidHaste, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    -- 49% DW (NIN)
    sets.engaged.DW.Melee.LowHaste = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Eabani Earring",
        body="Adhemar Jacket +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_dw,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet=gear.herc_feet_ta}

    sets.engaged.DW.Melee.DT.LowHaste = set_combine(sets.engaged.DW.Melee.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.LowHaste = set_combine(sets.engaged.DW.Melee.LowHaste, sets.engaged.Acc)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.Acc = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_da,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Meghanada Jambeaux +2"}

    sets.engaged.Acc.DW = {ammo=gear.RAbullet,
        head="Dampening Tam",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.camulus_dw,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Meghanada Jambeaux +2"}

    -- Engaged but only for WS
    --sets.engaged.Ranged = {ammo=gear.RAbullet,
    --   head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Telos Earring",ear2="Suppanomimi",
    --   body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Petrov Ring",ring2="Epona's Ring",
    --   back=gear.camulus_tp,waist="Eschan Stone",legs="Malignance Tights",feet="Meghanada Jambeaux +2"}
    
    sets.engaged.Ranged = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.camulus_snap,waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}
    sets.engaged.DW.Ranged = sets.engaged.Ranged
    sets.engaged.DW.Ranged.LowHaste = sets.engaged.Ranged
    sets.engaged.DW.Ranged.MidHaste = sets.engaged.Ranged
    sets.engaged.DW.Ranged.MaxHaste = sets.engaged.Ranged
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    end

    if spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    -- Equip obi if weather/day matches for WS.
    elseif spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' and (world.weather_element == 'Dark' or world.day_element == 'Dark') then
            equip({waist="Hachirin-no-Obi"})
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip({waist="Hachirin-no-Obi"})
        end
                    
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
        equip(sets.TripleShot)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end

    --[[
    if state.Gun.current == 'Fomalhaut' then
        equip({range="Fomalhaut"})
    elseif state.Gun.current == 'Death Penalty' then
        equip({range="Death Penalty"})
    elseif state.Gun.current == 'Anarchy +2' then
        equip({range="Anarchy +2"})
    end
    ]]--
    equip({ranged=state.Gun.current})

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    -- Gun toggle
    if stateField == 'Current Gun' then
        equip({range=state.Gun.current})
    end

    if stateField == 'Weapon Lock' then
        if newValue == true then
            disable('range')
        else
            enable('main','sub','range')
        end
    end
    
    if stateField == 'Offense Mode' then
        if newValue == 'Melee' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                state.CombatForm:set('DW')
            end
            disable('main','sub','range')
        elseif newValue == 'Ranged' then
            if state.WeaponLock.value ~= true then
                enable('main','sub','range')
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Gun.current == 'Doomsday' then
        equip({ranged="Doomsday"})
    elseif state.Gun.current == 'Molybdosis' then
        equip({ranged="Molybdosis"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Anarchy +2' then
            equip({ranged="Anarchy +2"})
    end
    return idleSet
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    local msg2 = ''

    msg = msg .. 'Gun:['..state.Gun.current..'] '
    msg = msg .. 'Off:['..state.OffenseMode.current ..']'

    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
            msg = msg .. ' ' .. v .. ''
        end
    end

    msg = msg .. ' Rng:['..state.RangedMode.current ..']'
    msg = msg .. ' WS:['..state.WeaponskillMode.current ..']'
    msg = msg .. ' QD:['..state.QuickDraw.value ..']'

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg2 = msg2 .. 'Defense:['..state.DefenseMode.value..'/'..defMode ..']'
    end
    
    if state.Kiting.value then
        msg2 = msg2 .. ' Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg2 = msg2 .. ' Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg2 = msg2 .. ' Target NPCs'
    end

    --msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)
    add_to_chat(122, msg2)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        --add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        --add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
        add_to_chat(104, ' Lucky: [ '..tostring(rollinfo.lucky)..' ]  Unlucky: [ '..tostring(rollinfo.unlucky)..' ]  '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')

    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name] or player.wardrobe2[bullet_name] or player.wardrobe3[bullet_name] or player.wardrobe4[bullet_name] or player.wardrobe5[bullet_name] or player.wardrobe6[bullet_name] or player.wardrobe7[bullet_name] or player.wardrobe8[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            if gear.RAbullet ~= gear.WSbullet then
                add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
                return
            end
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end