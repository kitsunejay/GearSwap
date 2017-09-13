------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
------------------------------------------------------------------------------
 
    sets.reive = {neck="Arciela's Grace +1"}
 
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    if buffactive['Reive Mark'] then --and player.inventory["Arciela's Grace +1"] or player.wardrobe["Arciela's Grace +1"] then
       equip(sets.reive)
    end
 
    if player.equipment.back == 'Mecisto. Mantle' then      
        disable('back')
    else
        enable('back')
    end
end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end