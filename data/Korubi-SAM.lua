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
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

    --update_offense_mode()    
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.IdleMode:options('Normal', 'DT')
    
	-- Ambuscade Capes
    gear.smertrios_wsd 	={	name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} 
    gear.smertrios_tp   ={  name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

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
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote +1",back=gear.smertrios_wsd}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
    sets.precast.JA['Meikyo Shisui'] = {hands="Sakonji Sune-ate"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
        head=gear.valorous_head_wsd,neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Sakonji Domaru +3",hands=gear.valorous_hands_wsd,ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back=gear.smertrios_wsd,waist="Fotia Belt",legs="Wakido Haidate +3",feet="Flamma Gambieras +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Sets to return to when not performing an action.    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Warp Ring",
        back=gear.smertrios_wsd,waist="Flume Belt",legs="Ryuo Hakama",feet="Danzo Sune-Ate"}
    
    sets.idle.Field = {
        head="Valorous Mask",neck="Twilight Torque",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Kasuga Domaru +1",hands="Wakido Kote +3",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Kendatsuba Hakama",feet="Danzo Sune-Ate"}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Sanctity Necklace",ear1="Genmei Earring",ear2="Etiolation Earring",
        body="Twilight Mail",hands="Wakido Kote +3",ring1="Defending Ring",ring2="Vocane Ring",
        back=gear.smertrios_tp,waist="Flume Belt",legs="Ryuo Hakama",feet="Flamma Gambieras +2"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Kasuga Domaru +1",ring1="Defending Ring",ring2="Vocane Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Kendatsuba Hakama",feet="Flamma Gambieras +2"}

    sets.defense.MDT = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Twilight Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Kasuga Domaru +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Kendatsuba Hakama",feet="Flamma Gambieras +2"}

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
        head="Flamma Zucchetto +2",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back="Takaha Mantle",waist="Ioskeha Belt",legs="Ryuo Hakama",feet="Ryuo Sune-ate"}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flamma Zucchetto +2",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
        body=gear.valorous_body_tp,hands="Wakido Kote +3",ring1="Niqmaddu Ring",ring2="Flamma Ring",
        back="Takaha Mantle",waist="Ioskeha Belt",legs="Ryuo Hakama",feet="Flamma Gambieras +2"}
    sets.engaged.DT = {ammo="Ginsen",
        head="Kendatsuba Jinpachi",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
        body="Wakido Domaru +2",hands="Wakido Kote +3",ring1="Vocane Ring",ring2="Defending Ring",
        back="Takaha Mantle",waist="Ioskeha Belt",legs="Kendatsuba Hakama",feet="Ryuo Sune-ate"}
    sets.engaged.Acc.DT = {ammo="Ginsen",
        head="Kendatsuba Jinpachi",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
        body="Wakido Domaru +2",hands="Wakido Kote +3",ring1="Vocane Ring",ring2="Defending Ring",
        back=gear.smertrios_tp,waist="Ioskeha Belt",legs="Kendatsuba Hakama",feet="Flamma Gambieras +2"}

    sets.buff.Sekkanoki = {hands="Kasuga Kote"}
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
    --update_offense_mode()
    determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_offense_mode()
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action', 
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    add_to_chat(122, '[  Flurry Status: Flurry I  ]')
                    flurry = 1
                elseif param == 846 then
                    add_to_chat(122, '[  Flurry Status: Flurry II  ]')
                    flurry = 2				
                elseif param == 57 and haste ~=2 then
                    add_to_chat(122, '[  Haste Status: Haste I (Haste)  ]')
                    haste = 1
                elseif param == 511 then
                    add_to_chat(122, '[  Haste Status: Haste II (Haste II)  ]')
                    haste = 2
                end
            elseif act.category == 5 then
                if act.param == 5389 then
                    add_to_chat(122, '[  Haste Status: Haste II (Spy Drink)  ]')
                    haste = 2
                end
            elseif act.category == 13 then
                local param = act.param
                --595 haste 1 -602 hastega 2
                if param == 595 and haste ~=2 then 
                    add_to_chat(122, '[  Haste Status: Haste I (Hastega)  ]')
                    haste = 1
                elseif param == 602 then
                    add_to_chat(122, '[  Haste Status: Haste II (Hastega2)  ]')
                    haste = 2
                end
            end
        end
    end)

function determine_haste_group()

    -- Assuming the following values:

    -- Haste - 15%
    -- Haste II - 30%
    -- Haste Samba - 5%
    -- Honor March - 15%
    -- Victory March - 25%
    -- Advancing March - 15%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30%

    classes.CustomMeleeGroups:clear()

    if state.CombatForm.value == 'DW' then

        if (haste == 2 and (buffactive[580] or buffactive.march or buffactive.embrava or buffactive[604])) or
            (haste == 1 and (buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or (buffactive.march and buffactive[604]))) or
            (buffactive[580] and (buffactive.march or buffactive.embrava or buffactive[604])) or
            (buffactive.march == 2 and (buffactive.embrava or buffactive[604])) or
            (buffactive.march and (buffactive.embrava and buffactive['haste samba'])) then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
            state.DualWield:set()
        elseif ((haste == 2 or buffactive[580] or buffactive.march == 2) and buffactive['haste samba']) or
            (haste == 1 and buffactive['haste samba'] and (buffactive.march or buffactive[604])) or
            (buffactive.march and buffactive['haste samba'] and buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
            state.DualWield:set()
        elseif (haste == 2 or buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or
            (haste == 1 and (buffactive.march or buffactive[604])) or (buffactive.march and buffactive[604])) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('MidHaste')
            state.DualWield:set()
        elseif (haste == 1 or buffactive.march or buffactive[604] or buffactive.embrava) then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
            state.DualWield:set()
        else
            state.DualWield:set(false)
        end
    end
end
