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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    --state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.CastingMode:options('Normal', 'Mid', 'Resistant', 'Proc', 'CMP')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')
    state.ConsMP=M(false, 'Conserve MP')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    -- Skirmish Armor
    
	-- Adoulin JSE Capes
	gear.bane_fc ={ name="Bane Cape", augments={'"Fast Cast" +3', 'Elem. Magic Skill +7', 'Dark Magic Skill +8'}}
	gear.bane_mp ={ name="Bane Cape", augments={'"Mag. Atk. Bns." +1', 'Elem. Magic Skill +4', 'Dark Magic Skill +10'}}
	
	-- Ambuscade Capes
	gear.taranus_macc ={ name="Taranus's Cape", augments={'"Mag. Atk. Bns." +10','Mag. Acc. +20/Mag. Dmg. +20','Mag. Acc. +10', 'INT +20'}}
	gear.taranus_mb ={ name="Taranus's Cape", augments={'"Mag. Atk. Bns." +10','Mag. Acc. +20/Mag. Dmg. +20','Mag. Acc. +10', 'INT +20'}}
    gear.taranus_fc ={ name="Taranus's Cape", augments={'"Fast Cast" +10"'}}
	-- Ru'an
	gear.amalric_legs_A ={ name="Amalric Slops", augments={'"Mag. Atk. Bns." +15', 'Mag. Acc. +15', 'MP +60'}}
	
	-- Reisenjima
	-- > in Mote-Globals
	
	-- Additional local binds
    send_command('bind ^` gs c toggle ConsMP')
    send_command('bind !` gs c toggle MagicBurst')
    

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
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +1", 
        back="Taranus's Cape"
    }

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells
        -- Fast Cast caps at 80%; BLM JT: 0%
        -- 
    sets.precast.FC = {
        head=gear.merlin_head_fc,   --13%
        neck="Sanctity Necklace",
        ear1="Loquacious Earring",  --1%
        ear2="Etiolation Earring",  --2%   
        body="Rosette Jaseran",     --3%+
        hands="Mallquis Cuffs +1",
        ring1="Defending Ring",
        ring2="Kishar Ring",        --5%
        back=gear.taranus_fc,       --9%
        waist="Cetl Belt",
        legs="Psycloth Lappas",     --7%
        feet=gear.merlin_feet_fc    --10%
    }

    -- Fast Cast caps at 80%; BLM Elemental JT: 30%
    --      JP Bonus:   
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,{
        neck="Stoicheion Medal",
        ear1="Barkarole Earring",
        body="Mallquis Saio +1",
        ring1="Mallquis Ring",
        hands="Mallquis Cuffs +1"
    })
    
    sets.ConsMP = {body="Spaekona's Coat +2"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		body="Vanya Robe"})
    
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Evans Earring",ear2="Etiolation Earring",
        body="Witching Robe",hands="Mallquis Cuffs +1",ring1="Mephitas's Ring +1",ring2="Etana Ring",
        back=gear.bane_mp,waist="Fucho-no-obi",legs=gear.amalric_legs_mp,feet="Psycloth Boots"}   
    
    ---- Midcast Sets ----

	-- Default midcast set
    sets.midcast.FastRecast = {
        head="Mallquis Chapeau",ear2="Loquacious Earring",
        body="Psycloth Vest",hands="Bokwus Gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Cetl Belt",legs="Hagondes Pants +1",feet="Mallquis Clogs +1"}

    sets.midcast.Cure = {ammo="Pemphredo Tathlum",
        head="Vanya Hood",neck="Nodens Gorget",ear1="Calamitous Earring", ear2="Mendicant's Earring",
        body="Vanya Robe",hands="Jhakri Cuffs +1",ring1="Defending Ring",ring2="Sirona's Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Assiduity Pants +1",feet="Vanya Clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head=gear.telchine_head_enh_dur,    --10%(aug)
        body=gear.telchine_body_enh_dur,    --8%(aug) // max 10%
        hands=gear.telchine_hands_enh_dur,  --1%(aug)
        legs=gear.telchine_legs_enh_dur,
        back="Perimede Cape",            
        feet="Regal Pumps +1"               
    }
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget"})

    sets.midcast['Enfeebling Magic'] = {main="Raetic Staff",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Vanya Robe",hands="Jhakri Cuffs +1",ring1="Etana Ring",ring2="Perception Ring",
        back=gear.taranus_macc,waist="Eschan Stone",legs="Psycloth Lappas",feet="Medium's Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Psycloth Vest",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Evanescence Ring",
        back=gear.taranus_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

    sets.midcast.Drain = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Psycloth Vest",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Evanescence Ring",
        back=gear.taranus_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet=gear.merlin_feet_fc}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Perception Ring",
        back=gear.taranus_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

    sets.midcast.BardSong = {
        head="Mallquis Chapeau",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Barkarole Earring",
        body="Mallquis Saio +1",hands="Mallquis Cuffs +1",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",legs="Jhakri Slops +1",feet="Bokwus Boots"}


    -- Elemental Magic sets
		
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Acumen Ring",
        back=gear.taranus_mb,waist="Refoccilation Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}

    sets.midcast['Elemental Magic'].Resistant = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Barkarole Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Acumen Ring",
        back=gear.taranus_macc,waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}
    	
    --sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    --sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
        main="Earth Staff", 
        sub="Mephitis Grip",
        ammo="Impatiens",
        head="Nahtirah Hat",
        neck="Twilight Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        body="Manasa Chasuble",
        hands="Serpentes Cuffs",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Swith Cape +1",
        waist="Witful Belt",
        legs="Mallquis Trews",
        feet="Chelona Boots +1"
    }


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        head="Mallquis Chapeau",neck="Beak Necklace",
        body="Mallquis Saio +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Qiqirn Sash",legs="Sagacity Lappas",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Lugalbanda Earring",ear2="Etiolation Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Assiduity Pants +1",feet="Crier's Gaiters"}
    
    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
        head="Hike Khat",neck="Sanctity Necklace",
        body="Mallquis Saio +1",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Mallquis Clogs +1"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Thureous Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +1",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Crier's Gaiters"}
    

    -- Town gear.
    sets.idle.Town = {main="Contemplator",sub="Niobid Strap",ammo="Impatiens",
        neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Etiolation Earring",
        body="Poroggo Coat",hands="Amalric Gages",ring1="Defending Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Assiduity Pants +1",feet="Crier's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {
        head="Hike Khat",neck="Twilight Torque",
        body="Mallquis Saio +1",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Mallquis Clogs +1"}

    sets.defense.MDT = {
        head="Vanya Hood",neck="Twilight Torque",ear2="Coral Earring",
        body="Mallquis Saio +1",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Defending Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Amalric Slops",feet="Mallquis Clogs +1"}

    sets.Kiting = {feet="Crier's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {
        main="Earth Staff",
        sub="Enki Strap",
        ammo="Strobilus",
        head="Befouled Crown",
        body="Mallquis Saio +1",
        --hands="",
        legs="Assid. Pants +1",
        feet="Wicce Sabots +1",
        neck="Twilight Torque",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Genmei Earring",
        left_ring="Vocane Ring",
        right_ring="Defending Ring",
        back=gear.taranus_macc,
    }

    -- Magic Burst Bonus: Job traits + JP category + Gifts + Gear 
    --      (Theoretical cap at 107% with Amalric Gages +1, 106% otherwise) 
    --      42/40      Gear soft cap,
    --      10/11    Burst II, 
    --      13/13    Job trait, 
    --      20/20    Job point category
    --      16/23      gifts
    sets.magic_burst = { 
		head=gear.merlin_head_mbd,		-- 	 7%	
        neck="Mizukage-no-Kubikazari", 	-- 	 10%
        body="Ea Houppelande",          --t2 8% / t1 8%
        hands="Amalric Gages", 			--t2 5%
        ring1="Mujin Band",			    --t2 5%
        ring2="Locus Ring",				--	 5%
        back=gear.taranus_mb,           --   5%
        legs="Merlinic Shalwar",
        feet="Jhakri Pigaches +2"		--	 7%
        --feet=gear.merlin_feet_mbd       --   8%
	}
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Aurist's Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +2"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(set_combine(sets.midcast['Elemental Magic'], {waist="Hachirin-no-Obi",}))
        end
        if spell.english == 'Death' then
            equip(sets.midcast['Death'])
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if state.CastingMode.value == "Resistant" then
			equip(set_combine(sets.midcast['Elemental Magic'].Resistant, sets.magic_burst))
		else
			equip(set_combine(sets.midcast['Elemental Magic'], sets.magic_burst))
        end
    end
    if spell.skill == 'Elemental Magic' and state.ConsMP.value then
            equip(sets.ConsMP)
            --add_to_chat(121,'Equiping AF+1 body')
    end
    if spell.action_type == 'Magic' then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.skill == "Elemental Magic" then
                equip({waist="Hachirin-no-Obi",})
                add_to_chat('Equiping obi for Elemental')
            elseif spellMap == "Cure" then
                if spellMap == 'Cure' and spell.target.type == 'SELF' then
                    equip({waist="Hachirin-no-Obi",})
                    add_to_chat('Equiping obi for CureSelf')
                else
                    equip(set_combine(sets.midcast.Cure),{waist="Hachirin-no-Obi",})
                    add_to_chat('Equiping obi for Cure')
                end
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    --add_to_chat('-------- Gained Buff: [ '..spell.english..' ] --------' )
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        --elseif spell.skill == 'Elemental Magic' then
         --   state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    elseif buff == "Mana Wall" and gain then

    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
end
