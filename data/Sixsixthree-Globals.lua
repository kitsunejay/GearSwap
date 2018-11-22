------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
------------------------------------------------------------------------------
function define_global_sets()
-- Special gear info that may be useful across jobs.

	sets.reive = {neck="Adoulin's Refuge +1"}

	gear.merlinic_head_fc = { name="Merlinic Hood", augments={'"Fast Cast"+6','DEX+11','Accuracy+2 Attack+2',}}
	gear.merlinic_feet_fc = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+12','"Fast Cast"+4','Mag. Acc.+13',}}

end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	sets.reive = {neck="Adoulin's Refuge +1"}

    if buffactive['Reive Mark'] then
		equip(sets.reive)
		disable('neck')
		if _settings.debug_mode then
			add_to_chat(123,'Debug: Reive Buff Active; equiping ['..tostring(player.equipment.neck)..']')
		end
	else
		if player.equipment.neck =="Arciela's Grace +1" then
			enable('neck')
			if _settings.debug_mode then
				add_to_chat(123,'Debug: No Reive Mark active; enabling neck')
			end
		end
    end
 
    if player.equipment.back == 'Mecisto. Mantle' then      
        disable('back') 
		if _settings.debug_mode then
			add_to_chat(123,'Debug: Ignoring Back because ['..tostring(player.equipment.back)..']')
		end
    else
        enable('back')
    end
end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end