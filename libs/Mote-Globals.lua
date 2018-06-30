-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to user, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the 'gear' table.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.Staff.HMP = 'Chatoyant Staff'
	gear.Staff.PDT = 'Earth Staff'
	
	-- Dark Rings
	gear.DarkRing = {}
	gear.DarkRing.physical = {name="Dark Ring",augments={'Magic dmg. taken -3%','Spell interruption rate down -5%','Phys. dmg. taken -6%'}}
	gear.DarkRing.magical = {name="Dark Ring", augments={'Magic dmg. taken -6%','Breath dmg. taken -5%'}}
	
	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.default.obi_waist = "Hachirin-no-obi"
	gear.default.obi_back = "Toro Cape"
	gear.default.obi_ring = "Strendu Ring"
	gear.default.fastcast_staff = ""
	gear.default.recast_staff = ""
	
	-- Skirmish
	gear.telchine_head_enh_dur 	= { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}

	-- Dusktip 5/5 Leaftip 3/5
	gear.taeon_head_snap 		= { name="Taeon Chapeau", augments={'"Snapshot"+4','"Snapshot"+5',}}

	-- Ru'an
	gear.adhemar_legs_tp 		= { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
	gear.adhemar_legs_preshot 	= { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}} 

	-- Reisenjima
	gear.merlin_feet_fc  = { name="Merlinic Crackows", augments={'Mag. Acc.+10 "Mag.Atk.Bns."+10','"Fast Cast"+5','MND+2','Mag. Acc.+12','"Mag.Atk.Bns."+9'}}
	gear.merlin_head_fc  = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','"Fast Cast"+5','Mag. Acc.+2',}}
	gear.merlin_head_mbd = { name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','"Mag.Atk.Bns."+14',}}
	gear.merlin_legs_mbd = { name="Merlinic Shalwar", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Magic burst dmg.+7%','Mag. Acc.+11','"Mag.Atk.Bns."+4',}}
	gear.merlin_legs_mab = { name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','MND+8','Mag. Acc.+4','"Mag.Atk.Bns."+13',}}
	gear.merlin_hands_fc = { name="Merlinic Dastanas", augments={'"Fast Cast"+6','CHR+9','Mag. Acc.+15',}}

	gear.chironic_head_curepot 	= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}
	gear.chironic_head_mnd 		= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}
	gear.chironic_pants_macc 	= { name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Resist Silence"+3','INT+4','Mag. Acc.+14',}}
	gear.chironic_feet_refresh 	= { name="Chironic Slippers", augments={'Pet: DEX+12','Damage taken-3%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.chironic_hands_refresh = { name="Chironic Gloves", augments={'STR+9','Pet: Mag. Acc.+10','"Refresh"+2','Accuracy+18 Attack+18',}}
	gear.chironic_hands_macc 	= { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','MND+8','Mag. Acc.+3','"Mag.Atk.Bns."+7',}}
	
	gear.valorous_head_wsd 	= {	name="Valorous Mask", augments={'Accuracy+9','Weapon skill damage +2%','STR+15','Attack+3',}}
	gear.valorous_hands_wsd = { name="Valorous Mitts", augments={'Crit. hit damage +2%','Weapon skill damage +4%','Accuracy+12 Attack+12',}}
	gear.valorous_body_tp 	= { name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+6','AGI+3','Accuracy+12','Attack+4',}}
	
	gear.odyssean_feet_fc 		= { name="Odyssean Greaves", augments={'Pet: Accuracy+7 Pet: Rng. Acc.+7','"Mag.Atk.Bns."+7','"Fast Cast"+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.odyssean_feet_refresh 	= { name="Odyssean Greaves", augments={'INT+2','Rng.Atk.+25','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}

	gear.herc_legs_mabwsd = { name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +3%','Mag. Acc.+3',}}
	gear.herc_head_mabwsd = { name="Herculean Helm", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','STR+6','"Mag.Atk.Bns."+15',}}
	
	-- Crafting
	sets.crafting_skillup = {head="Midras's Helm +1",ring1="Craftkeeper's Ring",ring2="Artificer's Ring"}
	sets.crafting_hq = set_combine(sets.crafting_skillup, {ring1="Craftmaster's Ring"})
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------

-- Function to bind GearSwap binds when loading a GS script.
function global_on_load()
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle HybridMode')
	send_command('bind !f9 gs c cycle RangedMode')
	send_command('bind @f9 gs c cycle WeaponskillMode')
	send_command('bind f10 gs c set DefenseMode Physical')
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	send_command('bind !f10 gs c toggle Kiting')
	send_command('bind f11 gs c set DefenseMode Magical')
	send_command('bind ^f11 gs c cycle CastingMode')
	send_command('bind f12 gs c update user')
	send_command('bind ^f12 gs c cycle IdleMode')
	send_command('bind !f12 gs c reset DefenseMode')

	send_command('bind ^- gs c toggle selectnpctargets')
	send_command('bind ^= gs c cycle pctargetmode')

	haste_string = ''

end

-- Function to revert binds when unloading.
function global_on_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind @f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')

	send_command('unbind ^-')
	send_command('unbind ^=')

	haste_string = ''
end

-------------------------------------------------------------------------------------------------------------------
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

-- Global intercept on precast.
function user_precast(spell, action, spellMap, eventArgs)
    cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
    refine_waltz(spell, action, spellMap, eventArgs)
end

-- Global intercept on midcast.
function user_midcast(spell, action, spellMap, eventArgs)
	-- Default base equipment layer of fast recast.
	if spell.action_type == 'Magic' and sets.midcast and sets.midcast.FastRecast then
		equip(sets.midcast.FastRecast)
	end
end

-- Global intercept on buff change.
function user_buff_change(buff, gain, eventArgs)
	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if buff:lower() == 'weakness' then
		if gain then
			send_command('timers create "Weakness" 300 up abilities/00255.png')
		else
			send_command('timers delete "Weakness"')
		end
	end

	-- If we gain or lose any haste buffs, adjust gear.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste', 'erratic flutter'}:contains(buff:lower()) then
		--customize_melee_set()
		if not gain then
			haste = nil
			determine_haste_group()
		else
			determine_haste_group()
		end

		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
	-- If we gain or lose any flurry buffs, adjust gear.
	if S{'flurry'}:contains(buff:lower()) then
		if not gain then
			flurry = nil
			--add_to_chat(122, "Flurry status cleared.")
		end
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end 
end


function user_status_change(newStatus, oldStatus, eventArgs)
	determine_haste_group()
	if not midaction() then
		handle_equipping_gear(player.status)
	end
end

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
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2				
				elseif param == 57 and haste ~=2 then
                    --add_to_chat(122, 'Haste Status: Haste I (Haste)')
                    haste = 1
				elseif param == 511 then
					--add_to_chat(122, 'Haste Status: Haste II (Haste II)')
					if haste == 1 then
						haste = 2
						determine_haste_group()
					end
					haste = 2
                end
            elseif act.category == 5 then
				if act.param == 5389 then
                    --add_to_chat(122, 'Haste Status: Haste II (Spy Drink)')
                    haste = 2
                end
            elseif act.category == 13 then
                local param = act.param
                --595 haste 1 -602 hastega 2
				if param == 595 and haste ~=2 then 
                    --add_to_chat(122, 'Haste Status: Haste I (Hastega)')
                    haste = 1
				elseif param == 602 then
                    --add_to_chat(122, 'Haste Status: Haste II (Hastega2)')
					if haste == 1 then
						haste = 2
						determine_haste_group()
					end
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

	if (haste == 2 and (buffactive[580] or buffactive.march or buffactive.embrava or buffactive[604])) or
		(haste == 1 and (buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or (buffactive.march and buffactive[604]))) or
		(buffactive[580] and (buffactive.march or buffactive.embrava or buffactive[604])) or
		(buffactive.march == 2 and (buffactive.embrava or buffactive[604])) or
		(buffactive.march and (buffactive.embrava and buffactive['haste samba'])) then

		haste_string = "Magic Haste: 43%"
		add_to_chat(122, '-----	[  Magic Haste: 43%  ]	-----')
		
		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MaxHaste')
		end
	elseif ((haste == 2 or buffactive[580] or buffactive.march == 2) and buffactive['haste samba']) or
		(haste == 1 and buffactive['haste samba'] and (buffactive.march or buffactive[604])) or
		(buffactive.march and buffactive['haste samba'] and buffactive[604]) then

		haste_string = "Magic Haste: 35%"
		add_to_chat(122, '-----	[  Magic Haste: 35%  ]	-----')

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('HighHaste')
		end
	elseif (haste == 2 or buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or
		(haste == 1 and (buffactive.march or buffactive[604])) or (buffactive.march and buffactive[604])) then

		haste_string = "Magic Haste: 30%"	
		add_to_chat(122, '-----	[  Magic Haste: 30%  ]	-----')

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MidHaste')
		end
	elseif (haste == 1 or buffactive.march or buffactive[604] or buffactive.embrava) then			
		haste_string = "Magic Haste: 15%"
		add_to_chat(122, '-----	[  Magic Haste: 15%  ]	-----')

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('LowHaste')
		end
	else
		haste_string = ""
		add_to_chat(122, '-----	[  Magic Haste: 0%  ]	-----')

	end
end