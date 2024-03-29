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
	
	-- Dark Rings
	gear.DarkRing = {}
	gear.DarkRing.physical = {name="Dark Ring",augments={'Magic dmg. taken -3%','Spell interruption rate down -5%','Phys. dmg. taken -6%'}}
	gear.DarkRing.magical = {name="Dark Ring", augments={'Magic dmg. taken -6%','Breath dmg. taken -5%'}}
	
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
	
  	gear.telchine_head_pet_dt 	= { name="Telchine Cap", augments={'Mag. Evasion+16','Pet: "Regen"+2','Pet: Damage taken -4%',}}
	gear.telchine_body_pet_dt	= { name="Telchine Chas.", augments={'Mag. Evasion+21','Pet: "Regen"+2','Pet: Damage taken -4%',}}
	gear.telchine_legs_pet_dt	= { name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	gear.telchine_feet_pet_dt	= { name="Telchine Pigaches", augments={'Mag. Evasion+23','Pet: "Regen"+1','Pet: Damage taken -4%',}}

	gear.telchine_head_enh_dur 	= { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}

	gear.telchine_feet_song_fc 	= {name="Telchine Pigaches", augments={'Song spellcasting time -5%',}}

	gear.taeon_head_snap 		= { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
	
	-- Ru'an
	gear.adhemar_legs_tp 		= { name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}}
	gear.adhemar_legs_preshot 	= { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}} 

	-- Reisenjima
	gear.merlinic_head_fc 	= { name="Merlinic Hood", augments={'Mag. Acc.+9','"Fast Cast"+7','INT+10','"Mag.Atk.Bns."+5',}}
	gear.merlinic_body_fc 	= { name="Merlinic Jubbah", augments={'Accuracy+20','"Fast Cast"+6','MND+9',}}
	gear.merlinic_hands_fc 	= { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','Mag. Acc.+9',}}
	gear.merlinic_feet_fc 	= { name="Merlinic Crackows", augments={'Mag. Acc.+30','"Fast Cast"+6',}}
	
	gear.merlinic_head_refresh = { name="Merlinic Hood", augments={'MND+8','Pet: Accuracy+25 Pet: Rng. Acc.+25','"Refresh"+2','Accuracy+7 Attack+7',}}
	gear.merlinic_feet_refresh = { name="Merlinic Crackows", augments={'Blood Pact Dmg.+2','STR+10','"Refresh"+2',}}
	gear.merlinic_feet_th	   = { name="Merlinic Crackows", augments={'Pet: "Store TP"+10','Mag. Acc.+19','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}


	gear.herc_legs_mab = 	{ name="Herculean Trousers", augments={'Accuracy+18','Pet: DEX+7','Weapon skill damage +8%','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.herc_legs_sb = 	{ name="Herculean Trousers", augments={'STR+14','Weapon skill damage +4%','Accuracy+16 Attack+16',}}
	gear.herc_feet_mab =	{ name="Herculean Boots", augments={'DEX+9','STR+14','Damage taken-3%','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	gear.herc_feet_dt  = 	gear.herc_feet_mab

	------------------------------------------------------------------------------
	--  JSE Capes
	------------------------------------------------------------------------------
	
	-- BRD
	gear.intarabus_fc   = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}

    -- COR
    gear.camulus_wsd     = {  name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    gear.camulus_mwsd    = {  name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    gear.camulus_tp      = {  name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.camulus_snap	 = {  name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Phys. dmg. taken-10%',}}
    gear.camulus_savageb = {  name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.camulus_dw      = {  name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	--gear.camulus_da      = {  name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	
	-- GEO
    gear.lifestream_pet_dt =        { name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +10','Pet: Damage taken -3%','Damage taken-5%',}}
    gear.nantosuleta_pet_regen =    { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Phys. dmg. taken-10%',}}
    gear.natosuleta_cure =          { name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Cure" potency +10%',}}
	gear.natosuleta_mab =			{ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.natosuleta_fc =			{ name="Nantosuelta's Cape", augments={'HP+60','"Fast Cast"+10',}}
	gear.natosuleta_tp = 			{ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.natosuleta_wsd =			{ name="Nantosuelta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	-- SMN
	gear.conveyance_skill =			{ name="Conveyance Cape", augments={'Summoning magic skill +4','Pet: Enmity+10','Blood Pact Dmg.+2',}}
	gear.campestres_pet_macc =		{ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20',}}
    gear.campestres_pet_atk =		{ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','"Fast Cast"+10',}}
	gear.campestres_fc = gear.campestres_pet_atk

	-- dnc
	gear.senunas_crit   	= { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
	gear.senunas_wsd 		= { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.senunas_pyrrhic 	= { name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.senunas_tp 		= { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}

end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)

end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end