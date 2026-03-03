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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'MDT','Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
        
	-- Ambuscade Capes
    gear.cichol_ws 	={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
    gear.cichol_tp  ={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')

    select_default_macro_book()
    set_lockstyle(9)

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    --sets.precast.JA['Berserk'] = {feet="Agoge Calligae +1",body="Pummeler's Lorica +2",back=gear.cichol_tp}
    --sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1"}
    --sets.precast.JA['Warcry'] = {head="Agoge Mask +1"}

    sets.precast.FC['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}

    sets.midcast['Trust'] = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Nyame Helm",neck="Republican Platinum Medal",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.cichol_ws,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Torcleaver'] = {
        main="Montante +1",sub="Utu Grip",
        ammo="Knobkierrie",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Heathen's Earring +1",
        body="Dagon Breastplate",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cornelia's Ring",
        back=gear.brigantias_wsd,waist="Sailfi Belt +1",legs="Nyame Flancharad",feet="Nyame Sollerets"
    }
    
    --  40% STR / 40% VIT
    sets.precast.WS['Scourge'] = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Nyame Mail",hands="Sakpata's Gauntlets",ring1="Flamma Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"
    }

    sets.precast.WS['Resolution'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"
    }

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})

    sets.precast.WS['Entropy'] = {ammo="Seething Bomblet +1",
        head="Flamma Zucchetto +2",neck="Fotia Gorget",ear1="Shere Earring",ear2="Moonshade Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Metamorph Ring +1",ring2="Niqmaddu Ring",
        back=gear.cichol_ws,waist="Fotia Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"
    }
        -- Midcast Sets
    --sets.midcast.FastRecast = {}

    
    -- Sets to return to when not performing an action.    

    -- Idle sets
    sets.idle.Town = {      
        head="Hjarrandi Helm",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Dagon Breastplate",hands="Sakpata's Gauntlets",ring1="Regal Ring",ring2="Niqqmadu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}
    
    sets.idle.Field = {
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Shneddick Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Twilight Mail",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Flamma Gambieras +2"}
    
    -- Defense sets
    sets.defense.DT = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warrior's Bead Necklace +2",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.cichol_tp,waist="Flume Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

    --sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
        --main="Montante +1",sub="Utu Grip",
        ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Dedition Earring",ear2="Telos Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.MDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.cichol_tp,waist="Ioskeha Belt +1",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Sakpata's Breastplate",hands="Otronif Gloves",ring1="Defending Ring",ring2="Petrov Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Defending Ring",ring2="Petrov Ring",
        back="Ik Cape",waist="Goading Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}
    sets.engaged.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Defending Ring",ring2="Petrov Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Sakpata's Cuisses",feet="Flamma Gambieras +2"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
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
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 12)
    else
        set_macro_page(1, 12)
    end
end
