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
res = require('resources')

function define_global_sets()
	
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
	
	state.MarcatoSongs = M(false, 'MarcatoSongs')

	send_command('bind ^backspace gs c cycle MarcatoSongs')

	haste_string = ''
	previous_haste_level = 0
	current_haste_level = 0

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

	send_command('unbind ^backspace')

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

	if not gain then
		if _settings.debug_mode then
			add_to_chat(123,"User buff LOST: ["..buff:lower().."]")
		end
		--add_to_chat(123,"User buff LOST: ["..buff:lower().."]")
	else
		if _settings.debug_mode then
			add_to_chat(204,"User buff GAIN: ["..buff:lower().."]")
		end
		--add_to_chat(204,"User buff GAIN: ["..buff:lower().."]")
	end

	-- If we gain or lose any haste buffs, adjust gear.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		if _settings.debug_mode and buffactive.march then
			add_to_chat(200,'March Count:'..buffactive.march)
		end

		if not gain then
			if buffactive[580] or buffactive[228] or buffactive[370] then
				if haste_active["Haste"] then
					haste_active["Haste"] = nil
				elseif haste_active["Haste II"] then
					haste_active["Haste II"] = nil
				end
			elseif buff == "Haste" then
				add_to_chat(123,buff..'<=== 1lost')
				if haste_active["Haste"] then
					haste_active["Haste"] = nil
				elseif haste_active["Haste II"] then
					haste_active["Haste II"] = nil
				elseif haste_active["Erratic Flutter"] then
					haste_active["Erratic Flutter"] = nil
				elseif haste_active["Refueling"] then
					haste_active["Refueling"] = nil
				end
			else
				add_to_chat(123,buff..'<=== 2lost')
				haste_active[buff] = nil
			end
		end

		determine_haste_group()
	
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
	-- If we gain or lose any flurry buffs, adjust gear.
	if S{'flurry'}:contains(buff:lower()) then
		if not gain then
			flurry = nil
		end
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end 
end


function user_status_change(newStatus, oldStatus, eventArgs)
	--add_to_chat(123,"User status change")
	determine_haste_group()
	if not midaction() then
		handle_equipping_gear(player.status)
	end
end
--[[

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

				if _settings.debug_mode then
					add_to_chat(123,'Incoming Action: ['..param..']')
				end
				add_to_chat(200,'Incoming Action: ['..param..']')

                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2				
				elseif param == 57 and haste ~=2 then
                    add_to_chat(122, 'Haste Status: Haste I (Haste)')
					haste = 1
				elseif param == 710 then
                    add_to_chat(122, 'Haste Status: Erratic Flutter (Haste II)')
					if haste == 1 then
						haste = 2
						determine_haste_group()
					end
					haste = 2
				elseif param == 511 then
					add_to_chat(122, 'Haste Status: Haste II (Haste II)')
					if haste == 1 then
						haste = 2
						determine_haste_group()
					end
                end
            elseif act.category == 5 then
				if act.param == 5389 then
					add_to_chat(122, 'Haste Status: Haste II (Spy Drink)')
					if haste == 1 then
						haste = 2
						determine_haste_group()
					end
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
				end
            end
		end
    end)
--]]


-- Assuming the following values:

-- Haste Samba - 5%					buffactive[370]
-- Geo-Haste - 30%					buffactive[580]

haste_values = {
	['Haste'] = 			{id=57, value=15,name="Haste"},
	['Haste II'] = 			{id=511,value=30,name="Haste II"},
	["Honor March"] = 		{id=417,value=16,name="Honor March"},
	["Victory March"] = 	{id=420,value=25,name="Victory March"},
	["Advancing March"] = 	{id=419,value=16,name="Advancing March"},
	["Embrava"] = 			{id=478,value=25,name="Embrava"},		-- buffactive[228]
	["Mighty Guard"] = 		{id=750,value=15,name="Mighty Guard"},	-- buffactive[604]
	["Erratic Flutter"] = 	{id=710,value=30,name="Erratic Flutter"},	
	["Refueling"] = 		{id=530,value=10,name="Refueling"}
}

haste_active = {}

totaL_haste = 0

march_order = {}

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
				if _settings.debug_mode and act.param ~= 0 then
					add_to_chat(200,act.param..'=>['..res.spells[act.param].en..']')
				end
				if S{'57','511','417','419','420','478','530','710','750'}:contains(tostring(act.param)) then
					if not buffactive.Slow then
						if not haste_active[res.spells[act.param].en] then
							--Refueling
							if res.spells[act.param].en == "Refueling" then
								if not haste_active["Refueling"] then
									haste_active["Refueling"] = haste_values["Refueling"]
									-- Remove if competing buffs already exist
									for k,v in pairs(haste_active) do
										if S{"Haste","Haste II","Erratic Flutter"}:contains(k) then
											if _settings.debug_mode then
												add_to_chat(200,"Removing Refueling")
											end
											if haste_active["Refueling"] then
												haste_active["Refueling"] = nil
											end
										end
									end
								end
								determine_haste_group()
							-- Haste I 
							elseif res.spells[act.param].en == "Haste" then
								if not haste_active["Haste II"] and not haste_active["Erratic Flutter"] then
									haste_active["Haste"] = haste_values["Haste"]
									-- Overwrite Refueling
									if haste_active["Refueling"] then
										haste_active["Refueling"] = nil
									end
								elseif _settings.debug_mode then
									add_to_chat(200,"Not adding cuz of H2/EF")
								end
								determine_haste_group()
							-- Haste II
							elseif res.spells[act.param].en == "Haste II" then
								haste_active["Haste II"] = haste_values["Haste II"]
								for k,v in pairs(haste_active) do
									if S{"Haste","Refueling","Erratic Flutter"}:contains(k) then
										if haste_active["Haste"] then
											haste_active["Haste"] = nil
										elseif haste_active["Refueling"] then
											haste_active["Refueling"] = nil
										elseif haste_active["Erratic Flutter"] then
											haste_active["Erratic Flutter"] = nil
										end
									elseif _settings.debug_mode then
										add_to_chat(200,"not overwriting from H2")
									end
								end
								determine_haste_group()
							-- Erratic Flutter
							elseif res.spells[act.param].en == "Erratic Flutter" then
								haste_active["Erratic Flutter"] = haste_values["Erratic Flutter"]
								for k,v in pairs(haste_active) do
									if S{"Haste","Refueling","Haste II"}:contains(k) then
										if haste_active["Haste"] then
											haste_active["Haste"] = nil
										elseif haste_active["Refueling"] then
											haste_active["Refueling"] = nil
										elseif haste_active["Haste II"] then
											haste_active["Haste II"] = nil
										end
									elseif _settings.debug_mode then
										add_to_chat(200,"not overwriting from EF")
									end
								end
								determine_haste_group()
							elseif S{"Advancing March","Victory March","Honor March"}:contains(res.spells[act.param].en) then
								if state.MarcatoSongs.value == true then
									marcato_song = haste_values[res.spells[act.param].en]
									marcato_song.value = marcato_song.value * 1.5
									haste_active[res.spells[act.param].en] = marcato_song
								else
									haste_active[res.spells[act.param].en] = haste_values[res.spells[act.param].en]
								end
								determine_haste_group()
							elseif res.spells[act.param].en == "Flurry" then
								if flurry ~= 2 then
									flurry = 1	
								end
							elseif res.spells[act.param].en == "Flurry II" then
								flurry = 2
							else
								--add_to_chat(200,act.param..'||'..res.spells[act.param].en..'||'..haste_values[res.spells[act.param].en])
								haste_active[res.spells[act.param].en] = haste_values[res.spells[act.param].en]
								determine_haste_group()
							end
						elseif _settings.debug_mode then
							add_to_chat(200,'['..res.spells[act.param].en..'] already active')
						end
					else
						if _settings.debug_mode then
							add_to_chat(200,"SLOWWWWW")
						end
					end
				elseif _settings.debug_mode then
					add_to_chat(200,'['..res.spells[act.param].en..'] already active')
				end
            end
		end
    end)


function determine_haste_group()


--[[

-------------------------------------------------------------------------------------------------------------------							
					Magic Haste
	  				0%	10%	15%	30%	Cap
			T1(10)	64	60	57	46	26
	DW		T2(15)	59	55	52	41	21
			T3(25)	49	45	42	31	11
	Job		T4(30)	44	40	37	26	 6
			T5(35)	39	35	32	21	 1
	Tier	T6(37)	37	33	30	19	 0
-------------------------------------------------------------------------------------------------------------------
			/DNC	T2
			/NIN	T3
			THF 	T3 (T4 with 550JP)
			BLU		T3, T4(normal), T5
			NIN		T5	
-------------------------------------------------------------------------------------------------------------------
]]--

	-- Reset for recalculation
	classes.CustomMeleeGroups:clear()
	total_haste = 0

	-- Add up all forms of haste
	for k,v in pairs(haste_active) do
		total_haste = total_haste + v.value
	end

	-- Add up all non spell buffs
	if buffactive[370] then
		total_haste = total_haste + 5
		if _settings.debug_mode then
			add_to_chat(200,'Found Haste Samba')
		end
	end
	if buffactive[580] then
		total_haste = total_haste + 30
		if _settings.debug_mode then
			add_to_chat(200,'Found geo-haste')
		end
	end

	--0%
	if total_haste == 0 then
		current_haste_level = 0
		if previous_haste_level ~= current_haste_level then
			add_to_chat(005,'Calculated: NoHaste')
		end
		previous_haste_level = current_haste_level
		if _settings.debug_mode then
			add_to_chat(200,'Haste Forms:')
			for k,v in pairs(haste_active) do
				add_to_chat(200,k..' ['..v.value..']')
			end
		end
	--10% or less
	elseif total_haste <= 10 and total_haste > 0 then
		current_haste_level = 1
		if previous_haste_level ~= current_haste_level then
			add_to_chat(005,'Calculated: LowHaste') -- 74 DW 59 DNC 49 NIN
		end
		previous_haste_level = current_haste_level

		if _settings.debug_mode then
			add_to_chat(200,'Haste Forms:')
			for k,v in pairs(haste_active) do
				add_to_chat(200,k..' ['..v.value..']')
			end
		end
		if S{"NIN","THF","DNC"}:contains(player.main_job) or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('LowHaste')
		end
	--15%
	elseif total_haste <= 15 and total_haste > 10 then
		current_haste_level = 2
		if previous_haste_level ~= current_haste_level then
			add_to_chat(005,'Calculated: MidHaste') -- 67 DW 52 DNC 42 NIN
		end
		previous_haste_level = current_haste_level

		if _settings.debug_mode then
			add_to_chat(200,'Haste Forms:')
			for k,v in pairs(haste_active) do
				add_to_chat(200,k..' ['..v.value..']')
			end
		end
		if S{"NIN","THF","DNC"}:contains(player.main_job) or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MidHaste')
		end	
	--30%
	elseif total_haste <= 30 and total_haste > 15 then
		current_haste_level = 3
		if previous_haste_level ~= current_haste_level then
			add_to_chat(005,'Calculated: HighHaste') --56 DW // 41 DNC 31 NIN
		end
		previous_haste_level = current_haste_level

		if _settings.debug_mode then
			add_to_chat(200,'Haste Forms:')
			for k,v in pairs(haste_active) do
				add_to_chat(200,k..' ['..v.value..']')
			end
		end
		if S{"NIN","THF","DNC"}:contains(player.main_job) or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('HighHaste')
		end	--Max(43.75%). Assume anything over 30 is capped to not over equip DW
	elseif total_haste > 30 then
		current_haste_level = 4
		if previous_haste_level ~= current_haste_level then
			add_to_chat(005,'Calculated: MaxHaste')	--36 DW // 21 DNC 11 NIN
		end
		previous_haste_level = current_haste_level

		if _settings.debug_mode then
			add_to_chat(200,'Haste Forms:')
			for k,v in pairs(haste_active) do
				add_to_chat(200,k..' ['..v.value..']')
			end
		end
		if S{"NIN","THF","DNC"}:contains(player.main_job) or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MaxHaste')
		end
	end
	--[[
	if S{"NIN","THF","DNC"}:contains(player.main_job) or state.CombatForm.value == 'DW' then
		classes.CustomMeleeGroups:clear()
		classes.CustomMeleeGroups:append('MaxHaste')
	end
	]]--
end
	--[[
function determine_haste_group()

    -- Assuming the following values:

    -- Haste - 15%				[57]
    -- Haste II - 30%			[511]
    -- Haste Samba - 5%			buffactive[370]
    -- Honor March - 15%		[417]
    -- Victory March - 25%		[420]
    -- Advancing March - 15%	[419]
    -- Embrava - 25%			[478]	buffactive[228]
    -- Mighty Guard - 15%		buffactive[604]
	-- Geo-Haste - 30%			buffactive[580]
	
	if haste then
		add_to_chat(123,"Determing haste group: haste["..haste.."]")
	end

	classes.CustomMeleeGroups:clear()


	if (haste == 2 and (buffactive[580] or buffactive.march or buffactive.embrava or buffactive[604])) or
		(haste == 1 and (buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or (buffactive.march and buffactive[604]))) or
		(buffactive[580] and (buffactive.march or buffactive.embrava or buffactive[604])) or
		(buffactive.march == 2 and (buffactive.embrava or buffactive[604])) or
		(buffactive.march and (buffactive.embrava and buffactive['haste samba'])) then

		haste_string = "Magic Haste: 43%"
		if _settings.debug_mode then
			add_to_chat(122, '-----	[  Magic Haste: 43%  ]	-----')
		end		
		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MaxHaste')
		end
	elseif ((haste == 2 or buffactive[580] or buffactive.march == 2) and buffactive['haste samba']) or
		(haste == 1 and buffactive['haste samba'] and (buffactive.march or buffactive[604])) or
		(buffactive.march and buffactive['haste samba'] and buffactive[604]) then

		haste_string = "Magic Haste: 35%"
		if _settings.debug_mode then
			add_to_chat(122, '-----	[  Magic Haste: 35%  ]	-----')
		end

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('HighHaste')
		end
	elseif (haste == 2 or buffactive[580] or buffactive.march == 2 or (buffactive.embrava and buffactive['haste samba']) or
		(haste == 1 and (buffactive.march or buffactive[604])) or (buffactive.march and buffactive[604])) then

		haste_string = "Magic Haste: 30%"	
		if _settings.debug_mode then
			add_to_chat(122, '-----	[  Magic Haste: 30%  ]	-----')
		end

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('MidHaste')
		end
	elseif (haste == 1 or buffactive.march or buffactive[604] or buffactive.embrava) then			
		haste_string = "Magic Haste: 15%"
		if _settings.debug_mode then
			add_to_chat(122, '-----	[  Magic Haste: 15%  ]	-----')
		end

		if player.main_job == "THF" or player.main_job == "NIN" or player.main_job == "DNC" or state.CombatForm.value == 'DW' then
			classes.CustomMeleeGroups:append('LowHaste')
		end
	else
		haste_string = ""
		if _settings.debug_mode then
			add_to_chat(122, '-----	[  Magic Haste: 0%  ]	-----')
		end
	end
    if table.length(classes.CustomMeleeGroups) > 0 then
        for k, v in ipairs(classes.CustomMeleeGroups) do
			add_to_chat(123, v)
		end
	end
end
]]--

function set_lockstyle(lockset)
    send_command('wait 5; input /lockstyleset ' .. lockset)
end