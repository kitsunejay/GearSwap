-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')

    -- Daurdabla Trigger Songs --
	DaurdSongs = S{"Knight's Minne","Knight's Minne II","Goddess's Hymnus","Shining Fantasia"}

    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    set_lockstyle(6)

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
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Kali",sub="Genbu's Shield",
        head="Nahtirah Hat",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Embla Sash",legs="Ayanmo Cosciales +2",feet="Chelona Boots +1"
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet="Vanya Clogs",
    })

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.BardSong = {main="Kali",sub="Genbu's Shield",range="Gjallarhorn",
        head="Fili Calot +1",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Embla Sash",legs="Ayanmo Cosciales +2",feet=gear.telchine_feet_song_fc}
    
    sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Gjallarhorn",
        head="Nahtirah Hat",
        body="Inyanga Jubbah +2",hands="Buremte Gloves",
        back="Kumbira Cape",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ranged=None,ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back="Relucent Cape",waist="Grunfeld Rope",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS)

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Embla Sash",legs="Ayanmo Cosciales +2",feet="Chelona Boots +1"
    }
    
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave"}
    sets.midcast.Lullaby = {hands="Brioso Cuffs +2"}
    sets.midcast.Madrigal = {head="Fili Calot +1"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {}
    sets.midcast.Paeon = {head="Brioso Roundlet +1"}
    sets.midcast.Carol = {head="Fili Calot +1",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",
        feet="Fili Cothurnes +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    --sets.midcast['Magic Finale'] = {neck="Wind Torque",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {main="Kali",range="Gjallarhorn",
        head="Fili Calot +1",neck="Moonbow Whistle",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.intarabus_fc,waist="Embla Sash",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}
    
    sets.midcast['Honor March'] = set_combine(sets.midcast.SongEffect,{range="Marsyas"})

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {main="Kali",sub="Ammurapi Shield",range="Gjallarhorn",
        head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Hermetic Earring",ear2="Gwati Earring",
        body="Brioso Justaucorps +2",hands="Brioso Cuffs +2",ring1="Inyanga Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Luminary Sash",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main="Kali",sub="Ammurapi Shield",range="Gjallarhorn",
        head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Hermetic Earring",ear2="Gwati Earring",
        body="Brioso Justaucorps +2",hands="Inyanga Dastanas +2",ring1="Inyanga Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Luminary Sash",legs="Brioso Cannions +2",feet="Brioso Slippers +2"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Prolix Ring",
        back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {main="Izhiikoh",range=info.ExtraSongInstrument,
        head="Fili Calot +1",neck="Baetyl Pendant",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Inyanga Jubbah +2",hands="Gendewith Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Swith Cape +1",waist="Goading Belt",legs="Ayanmo Cosciales +2",feet="Bokwus Boots"}

    -- Other general spells and classes.
    sets.midcast.Cure = {main="Daybreak",sub="Genbu's Shield",range="Gjallarhorn",
        head="Vanya Hood",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Mendicant's Earring",
        body="Vanya Robe",hands="Inyanga Dastanas +2",ring1="Janniston Ring",ring2="Sirona's Ring",
        back="Solemnity Cape",waist="Porous Rope",legs="Kaykaus Tights +1",feet="Vanya Clogs"}
    
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Gishdubar Sash"}

    sets.midcast.CureWeather = {
        main="Chatoyant Staff",sub="Enki Strap",
        neck="Incanter's Torque",
        waist="Hachirin-no-Obi",
    }

    sets.midcast["Enfeebling Magic"] ={main="Daybreak",sub="Ammurapi Shield",range="Terpander",
        head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Hermetic Earring",ear2="Gwati Earring",
        body="Brioso Justaucorps +2",hands="Inyanga Dastanas +2",ring1="Inyanga Ring",ring2="Kishar Ring",
        back=gear.intarabus_fc,waist="Luminary Sash",legs="Brioso Cannions +2",feet="Brioso Slippers +2"}

    sets.midcast.MndEnfeebles = sets.midcast["Enfeebling Magic"]
    sets.midcast.IntEnfeebles = sets.midcast["Enfeebling Magic"]

    sets.midcast.Cursna = set_combine(sets.midcast.Cure,{
        neck="Malison Medallion",
        hands="Hieros Mittens",ring1="Ephedra Ring"})

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",              --10%*
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --10%
        waist="Embla Sash",                 --10%
        legs=gear.telchine_legs_enh_dur,    --10%(aug)
        feet=gear.telchine_feet_enh_dur     --9%
    }
    
    sets.midcast.FixedPotencyEnhancing = sets.midcast.EnhancingDuration
    sets.midcast["Enhancing Magic"] = {
        main="Pukulatmuj",
        sub="Ammurapi Shield",              --10%*
        neck="Incanter's Torque",
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --9%
        hands=gear.telchine_hands_enh_dur,  --10%
        waist="Olympus Sash",
        legs=gear.telchine_legs_enh_dur,    --10%(aug)
        feet=gear.telchine_feet_enh_dur     --9%
    }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration,{waist="Siegel Sash"})

    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle = {main="Daybreak", sub="Genbu's Shield",range="Terpander",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Solemnity Cape",waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Fili Cothurnes +1"}

    sets.idle.PDT = {main="Daybreak", sub="Genbu's Shield",range="Terpander",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Infused Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Solemnity Cape",waist="Porous Rope",legs="Brioso Cannions +2",feet="Fili Cothurnes +1"}

    sets.idle.Town = {main="Daybreak", sub="Ammurapi Shield",range="Marsyas",
        head="Inyanga Tiara +2",neck="Moonbow Whistle",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Janniston Ring",ring2="Warp Ring",
        back=gear.intarabus_fc,waist="Embla Sash",legs="Inyanga Shalwar +2",feet="Fili Cothurnes +1"}
    
    sets.idle.Weak = {main="Daybreak", sub="Genbu's Shield",range="Terpander",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Solemnity Cape",waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Fili Cothurnes +1"}
    
    
    -- Defense sets

    sets.defense.PDT = {main="Daybreak", sub="Genbu's Shield",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Solemnity Cape",waist="Porous Rope",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main="Daybreak", sub="Genbu's Shield",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Solemnity Cape",waist="Porous Rope",legs="Inyanga Shalwar +2",feet="Fili Cothurnes +1"}

    sets.Kiting = {feet="Fili Cothurnes +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Ginsen",
        head="Ayanmo Zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Telos Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back="Relucent Cape",waist="Windbuffet Belt",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {range="Angel Lyre",
        head="Ayanmo Zucchetto +2",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back="Relucent Cape",waist="Windbuffet Belt",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}

    -- Set if dual-wielding
    sets.engaged.DW = {range="Angel Lyre",
        head="Ayanmo Zucchetto +2",neck="Asperity Necklace",ear1="Telos Earring",ear2="Eabani Earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Ilabrat Ring",ring2="Petrov Ring",
        back="Relucent Mantle",waist="Windbuffet Belt",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if DaurdSongs:contains(spell.english) then
            equip(sets.precast.FC.Daurdabla)
        end
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            if DaurdSongs:contains(spell.english) then
                equip(sets.midcast.DaurdablaDummy)
                add_to_chat(158,'DaurdablaDummy: [ON]')
            end
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
    -- Weather checks
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.skill == "Elemental Magic" then
                --equip({waist="Hachirin-no-Obi",})
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

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    --[[
        if spell.type == 'BardSong' and not spell.interrupted then
            if spell.target and spell.target.type == 'SELF' then
                adjust_timers(spell, spellMap)
            end
        end
    --]]
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Enhancing Magic' then
            if S{'Refresh'}:contains(default_spell_map) then
                if spell.target.type == 'SELF' then
                    if _settings.debug_mode then
                        add_to_chat(123,'--- RefreshSelf ---')
                    end
                    return "RefreshSelf"
                end
            elseif not S{'Erase','Phalanx','Stoneskin','Aquaveil','Temper','Temper II','Shellra V','Protectra V'}:contains(spell.english)
            and not S{'Regen','Refresh','BarElement','BarStatus','EnSpell','StatBoost','Teleport'}:contains(default_spell_map) then
                if _settings.debug_mode then
                    add_to_chat(123,'--- FixedPotencyEnhancing ---')
                end 
                return "FixedPotencyEnhancing"
            end
        end
    end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
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

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    elseif DaurdSongs:contains(spell.english) then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)

    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +1" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +1' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +1" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)
    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end

function job_self_command(command)
    if command[1] == 'nitro1march' then
        send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
        add_to_chat(158,'H-March NT/Marcato 2Min')
    elseif command[1] == 'sing1march' then
        send_command('input /ma "honor march" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "valor minuet V" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
        add_to_chat(158,'H-March 2Min')
    elseif command[1] == 'resing1march' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>;')
		add_to_chat(158,'H-March/2Min Resing')
	elseif command[1] == 'nitro1acc' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/Mad NT/Marcato')
	elseif command == 'Nitro2Acc' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "sword madrigal" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/2Mad NT/Marcato')
	elseif command[1] == 'resing1Acc' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/Mad Resing')
	elseif command == 'Resing2Acc' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "sword madrigal" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/2Mad/Min Resing')
	elseif command == 'Rebuff1Acc' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "shining fantasia" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "knight\'s minne" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/Mad Rebuff')
	elseif command == 'Rebuff2Acc' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "shining fantasia" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "knight\'s minne" <me>; wait 6.5; input /ma "sword madrigal" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
		add_to_chat(158,'March/2Mad Rebuff')
	elseif command[1] == 'SP1march' then
		send_command('input /ja "soul voice" <me>; wait 1.5; input /ja "clarion call" <me>; wait 1.5; input /ja "nightingale" <me>; wait 1.5; input /ja "troubadour" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "Valor Minuet V" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 5; input /ja "pianissimo" <me>;')
		add_to_chat(158,'CP SP1/2 JA DD Songs')
	elseif command == 'Resing1march' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 6.5; input /ma "valor minuet III" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Jakar')
		add_to_chat(158,'March/Mad/3Min Resing')
	elseif command == 'Nitro1march' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ma "valor minuet III" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Jakar')
		add_to_chat(158,'March/Mad/3Min Resing')
	elseif command == 'SP2march' then
		send_command('input /ja "soul voice" <me>; wait 1.5; input /ja "clarion call" <me>; wait 1.5; input /ja "nightingale" <me>; wait 1.5; input /ja "troubadour" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "Victory march" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Sinlessrogue')
		add_to_chat(158,'SP1/2 2March/Mad/2Min')
	elseif command == 'Resing2march' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "blade madrigal" <me>; wait 6.5; input /ma "victory march" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Sinlessrogue')
		add_to_chat(158,'2March/Mad/2Min Resing')
	elseif command == 'Nitro2march' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "blade madrigal" <me>; wait 3.5; input /ma "victory march" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Sinlessrogue')
		add_to_chat(158,'2March/Mad/2Min Resing')
	elseif command == 'NitroPrange' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "archer\'s prelude" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Kobaine')
		add_to_chat(158,'Physical Ranged NT/Marcato')
	elseif command == 'ResingPrange' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "archer\'s prelude" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Kobaine')
		add_to_chat(158,'Physical Ranged Resing')
	elseif command == 'RebuffPrange' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "archer\'s prelude" <me>; wait 6.5; input /ma "shining fantasia" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "knight\'s minne" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 6.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" ')
		add_to_chat(158,'Physical Ranged Rebuff')
	elseif command == 'NitroAgi' then
		send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "swift etude" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "quick etude" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "archer\'s prelude" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" ')
		add_to_chat(158,'2AGI/RACC NT/Marcato')
	elseif command == 'ResingAgi' then
		send_command('input /ma "swift etude" <me>; wait 6.5; input /ma "honor march" <me>; wait 6.5; input /ma "quick etude" <me>; wait 6.5; input /ma "archer\'s prelude" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" ')
		add_to_chat(158,'2AGI/RACC Resing')
	elseif command == 'RebuffAgi' then
		send_command('input /ma "swift etude" <me>; wait 6.5; input /ma "honor march" <me>; wait 6.5; input /ma "shining fantasia" <me>; wait 6.5; input /ma "quick etude" <me>; wait 6.5; input /ma "shining fantasia" <me>; wait 6.5; input /ma "archer\'s prelude" <me>; wait 6.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>; wait 7.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" ')
        add_to_chat(158,'2AGI/RACC NT/Marcato')
    elseif command[1] == 'sbNitro' then
        send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "Lightning Carol II" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "lightning carol" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
        add_to_chat(158,'H-March NT/Marcato 2Min')
    elseif command[1] == 'sbSongs' then
        send_command('input /ma "honor march" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "Lightning Carol II" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "lightning carol" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>')
        add_to_chat(158,'H-March 2Min')
    elseif command[1] == 'sbResing' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "Lightning Carol II" <me>; wait 6.5; input /ma "lightning carol" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>;')
        add_to_chat(158,'H-March/2Min Resing')
    elseif command[1] == 'cpnitro' then
        send_command('input /ja "nightingale" <me>; wait 2; input /ja "troubadour" <me>; wait 1; input /ja "marcato" <me>; wait 3.5; input /ma "honor march" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet V" <me>; wait 3.5; input /ma "shining fantasia" <me>; wait 3.5; input /ma "valor minuet IV" <me>; wait 3.5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>;wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Cyrite;wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Wapiti')
        add_to_chat(158,'CP: H-March NT/Marcato 2Min')
    elseif command[1] == 'cpsing' then
        send_command('input /ma "honor march" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "valor minuet V" <me>; wait 7; input /ma "shining fantasia" <me>; wait 7; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Cyrite;wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Wapiti;wait 5; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Wapiti')
        add_to_chat(158,'CP: H-March 2Min')
    elseif command[1] == 'cpresing' then
		send_command('input /ma "honor march" <me>; wait 6.5; input /ma "valor minuet V" <me>; wait 6.5; input /ma "valor minuet IV" <me>; wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" <me>;wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Cyrite;wait 7; input /ja "pianissimo" <me>; wait 1; input /ma "mage\'s ballad III" Wapiti')
		add_to_chat(158,'CP: H-March/2Min Resing')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(2, 18)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
