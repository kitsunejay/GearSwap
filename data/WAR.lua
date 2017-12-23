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
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()

    
	-- Ambuscade Capes
    gear.cichol_tp 	={	name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
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
    sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Sakonji Kote"}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Flamma Zucchetto +2",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Valorous Hose",feet="Otronif Boots +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Argosy Hauberk",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Fotia Belt",legs="Pummeler's Cuisses +2",feet="Pummeler's Calligae +2"}
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget"})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Snow Belt"})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Thunder Gorget"})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Thunder Gorget"})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Thunder Belt"})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Snow Belt"})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})


    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Flamma Zucchetto +2",
        body="Otronif Harness +1",hands="Otronif Gloves",
        legs="Phorcys Dirs",feet="Otronif Boots +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {main="Tsurumaru", sub="Pole Grip",ammo="Ginsen",
        head="Leafkin Cap",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Kumarbi's Akar",hands="Wakido Kote +2",ring1="Defending Ring",ring2="Warp Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Phorcys Dirs",feet="Pummeler's Calligae +2"}
    
    sets.idle.Field = {
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Argosy Hauberk",hands="Sulevia's Gauntlets +2",ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Ioskeha Belt",legs="Pummeler's Cuisses +2",feet="Pummeler's Calligae +2"}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Vocane Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Pummeler's Cuisses +2",feet="Pummeler's Calligae +2"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +1"}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Valorous Hose",feet="Flamma Gambieras +1"}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Sulevia's Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Pummeler's Cuisses +2",feet="Pummeler's Calligae +2"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Flamma Manopolas +1",ring1="Rajas Ring",ring2="Flamma Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Flamma Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Flamma Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Flamma Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Flamma Korazin +1",hands="Wakido Kote +2",ring1="Petrov Ring",ring2="Flamma Ring",
        back=gear.cichol_tp,waist="Ioskeha Belt",legs="Ryuo Hakama",feet="Flamma Gambieras +1"}
    sets.engaged.Adoulin.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Unkai Domaru +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Adoulin.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Hizamaru Ring",
        back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Adoulin.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Ginsen",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Hizamaru Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Flamma Gambieras +1"}


    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
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

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 11)
    else
        set_macro_page(1, 11)
    end
end
