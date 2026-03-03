------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
------------------------------------------------------------------------------
function define_global_sets()
-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.Staff.HMP = 'Chatoyant Staff'
	gear.Staff.PDT = 'Earth Staff'
	
	sets.reive = {neck="Adoulin's Refuge +1"}
	sets.warp_ring = {ring2="Warp Ring"}
------------------------------------------------------------------------------

	-- Skirmish

	-- Pet: -DT (37.5% to cap)
	-- Duskorb: pet dt -4
	-- Leaforb: pet regen +3
	-- Leaftip: snapshot 4

	-- Linos WSD
	-- snowslit DONE
	-- leaftip da @2, MAX wsd 3
	-- dusktip dex + str@6, MAX dex 8

	-- Linos TP
	-- snowslit acc @14 , MAX 15acc/15attk
	-- leaftip stp@3 , MAX stp 4(engaged)
	-- dusktip DONE

	-- Koru
	-- snowslit - 20/20 acc/attk or 25acc
	-- dusktip - 7dex/7str or 10dex
	-- leafdim - SIRD 10%
	
	gear.telchine_head_enh_dur 	= { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +8',}}

	gear.vanya_body_skill 		= { name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.vanya_hands_skill 		= { name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

	gear.vanya_feet_cp 			= { name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
	gear.vanya_feet_skill 		= { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

    gear.vanya_head_fc 			= { name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
    gear.vanya_head_skill 		= { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

	
	-- Ru'an

	-- Reisenjima

	------------------------------------------------------------------------------
	--  JSE Capes
	------------------------------------------------------------------------------
	
	-- WHM

	-- SCH
	gear.lugh_fc    =  { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}} --resin
	--gear.lugh_mab   =  { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	gear.lugh_mab   =  { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

	-- RDM
	-- gear.sucellos_macc  ={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity-10',}} --resin
    
    --gear.sucellos_macc  ={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity-10',}} --resin
	gear.sucellos_macc  ={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Cure" potency +10%',}} --resin
    -- gear.sucellos_mab   ={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    -- gear.sucellos_dw    ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	gear.sucellos_stp   ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
    -- gear.sucellos_wsd   ={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --resin
	-- gear.sucellos_wsd_mnd ={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}} --resin
    -- gear.sucellos_crit  ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --resin

	-- THF

end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)

end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end