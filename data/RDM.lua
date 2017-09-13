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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.ambuMABback = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10'}}
    gear.ambuMaccBack = {name="Sucellos's Cape", augments={'MND+1','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10'}}   
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	    -- Fast Cast caps at 80%; RDM JT: 30%

    sets.precast.FC = {ammo="Hydrocera",
        head="Atrophy Chapeau +1",	--12%
		ear2="Loquacious Earring",	--2%
        body="Vitivation Tabard",	--12%
		hands="Leyline Gloves", 	--7%
		ring1="Jhakri Ring",
		waist="Witful Belt",
		legs="Lengo Pants", 		--5%
		feet="Merlinic Crackows",	--5%
		back="Swith Cape +1"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Atrophy Chapeau +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Oneiros Annulet",
        back="Atheling Mantle",waist="Caudata Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Soil Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Toro Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +1",ear2="Loquacious Earring",
        body="Vitivation Tabard",hands="Gendewitha Gages",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Hagondes Pants +1",feet="Hagondes Sabots"}

		--Cure potency > 50%    |   Enmity - 33
    sets.midcast.Cure = { ammo="Hydrocera",
        head="Gendewitha Caubeen",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
        body="Vanya Robe",hands="Jhakri Cuffs +1",ring1="Perception Ring",ring2="Sirona's Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Adhara Seraweels",feet="Jhakri Pigaches +1"}
    
	--sets.midcast.Cure.with_buff['reive mark'] = {neck="Arciela's Grace +1"}
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Vocane Ring",ring2="Sirona's Ring"}

    sets.midcast['Enhancing Magic'] = {
        head="Atrophy Chapeau +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanya Robe",hands="Atrophy Gloves",ring1="Perception Ring",ring2="Jhakri Ring",
        back="Sucello's Cape",waist="Eschan Stone",legs="Atrophy Tights",feet="Estoqueur's Houseaux +2"}

    sets.midcast.Refresh = {legs="Estoqueur's Fuseau +2"}

    sets.midcast.Stoneskin = {neck="Nodens Gorget", waist="Siegel Sash"}
    
    sets.midcast['Enfeebling Magic'] = {ammo="Hydrocera",
        head="Vitivation Chapeau",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vitivation Tabard",hands="Jhakri Cuffs +1",ring1="Perception Ring",ring2="Jhakri Ring",
        back="Ghostfyre Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
	
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Duelist's Tights +2"})
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Duelist's Tights +2"})
    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Boots"})
	
    sets.midcast['Elemental Magic'] = {ammo="Dosis Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Acumen Ring",
        back="Eloquence Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {ammo="Hydrocera",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Psycloth Vest",hands="Jhakri Cuffs +1",ring1="Jhakri Ring",ring2="Perception Ring",
        back="Refraction Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {hands="Atrophy Gloves",back="Estoqueur's Cape",feet="Estoqueur's Houseaux +2"}
        
    sets.buff.ComposureOther = {head="Estoqueur's Chappel +2",
        body="Estoqueur's Sayon +2",hands="Estoqueur's Gantherots +2",
        legs="Estoqueur's Fuseau +2",feet="Estoqueur's Houseaux +2"}

    sets.buff.Saboteur = {hands="Estoqueur's Gantherots +2"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitivation Chapeau",neck="Wiglen Gorget", 
        body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Duelist's Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {main="Marin Staff +1",sub="Clerisy Strap", ammo="Hydrocera",
        head="Vitivation Chapeau",neck="Wiglen Gorget",ear1="Psystorm Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Warp Ring",
        back="Solemnity Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Jhakri Pigaches +1"}

    sets.idle.Town = {main="Claidheamh Soluis",sub="Genbu's Shield",ammo="Hydrocera",
        head="Vitivation Chapeau",neck="Sanctity Necklace",ear1="Steelflash Earring",ear2="Loquacious Earring", 
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Vocane Ring",ring2="Warp Ring",
        back="Ghostfyre Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Jhakri Pigaches +1"}
    
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Hydrocera",
        head="Vitivation Chapeau",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Vocane Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Lengo Pants",feet="Jhakri Pigaches +1"}

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands="Gendewitha Gages",ring1="Vocane Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Osmium Cuisses",feet="Jhakri Pigaches +1"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Caubeen +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Jhakri Pigaches +1"}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Mecistopins Mantle",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +1",hands="Atrophy Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Jhakri Pigaches +1"}

	sets.engaged.DW = {ammo="Ginsen",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Jhakri Robe +2",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Jhakri Ring",
        back="Ghostfyre Cape",waist="Eschan Stone",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
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
        if player.equipment.sub and not player.equipment.sub:contains('Shield') then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end
