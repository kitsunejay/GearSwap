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
	
	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.default.obi_waist = "Hachirin-no-obi"
	gear.default.obi_back = "Toro Cape"
	gear.default.obi_ring = "Strendu Ring"
	gear.default.fastcast_staff = ""
	gear.default.recast_staff = ""

	
    sets.reive = {neck="Arciela's Grace +1"}
	sets.warp_ring = {ring2="Warp Ring"}
------------------------------------------------------------------------------

	-- Skirmish

	-- snowslit - 20/20 acc/attk or 25acc
	-- dusktip - 7dex/7str or 10dex
	-- leafslit - 5dw
	-- leafdim - SIRD 10%

	-- MAX - dex7/str7/acc20/attk20/ta2(dw5)

	-- Taeon Head - snowslit #1 // dusktip #1
	--	5/5/18acc/0/2
	-- Taeon Hands - snowslit #4
	--	7/7/24acc/2
	-- Taeon Legs - snowslit #3 // dusktip #2
	--	8dex/24acc/2
	-- Taeon Feet - leafslit #1 // snowslit #2
	--	6/6/15/15/4

	gear.telchine_head_enh_dur 	= { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}
	

	gear.taeon_head_phalanx		= { name="Taeon Chapeau", augments={'Spell interruption rate down -9%','Phalanx +3',}}
	gear.taeon_body_phalanx 	= { name="Taeon Tabard", augments={'Phalanx +3',}}
    gear.taeon_hands_phalanx	= { name="Taeon Gloves", augments={'Spell interruption rate down -4%','Phalanx +3',}}
    gear.taeon_legs_phalanx		= { name="Taeon Tights", augments={'Spell interruption rate down -5%','Phalanx +3',}}
	gear.taeon_feet_phalanx		= { name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}}
	

	gear.taeon_head_ta			= { name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','STR+5 DEX+5',}}
    gear.taeon_hands_ta			= { name="Taeon Gloves", augments={'Accuracy+24','"Triple Atk."+2','STR+7 DEX+7',}}
	gear.taeon_legs_ta			= { name="Taeon Tights", augments={'Accuracy+18 Attack+18','"Triple Atk."+2','DEX+8',}}
	gear.taeon_feet_dw			= { name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+4','STR+6 DEX+6',}}

	gear.taeon_head_snap 		= { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}

	-- Ru'an
	gear.adhemar_legs_tp 		= { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
	gear.adhemar_legs_preshot 	= { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}} 

	-- Reisenjima
	gear.merlin_head_fc  = 	{ name="Merlinic Hood", augments={'"Fast Cast"+7','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
	gear.merlin_body_fc =	{ name="Merlinic Jubbah", augments={'"Fast Cast"+7',}}
	gear.merlin_hands_fc = 	{ name="Merlinic Dastanas", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+7','INT+6',}}
	gear.merlin_feet_fc  = 	{ name="Merlinic Crackows", augments={'Mag. Acc.+16','"Fast Cast"+7',}}

	gear.merlin_head_mbd = 	{ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','"Mag.Atk.Bns."+14',}}
	gear.merlin_body_mbd = 	{ name="Merlinic Jubbah", augments={'Magic burst dmg.+11%','"Mag.Atk.Bns."+15',}}
	gear.merlin_legs_mbd = 	{ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','CHR+7','Mag. Acc.+9',}}
	gear.merlin_feet_mbd =  { name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+8%','INT+14','Mag. Acc.+14',}}

	gear.merlin_legs_mab =  { name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-2','INT+8','"Mag.Atk.Bns."+8',}}
	gear.merlin_feet_mab = 	{ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+9','Mag. Acc.+7','"Mag.Atk.Bns."+15',}}

	gear.merlinic_hands_aspir 	= { name="Merlinic Dastanas", augments={'Mag. Acc.+30','"Drain" and "Aspir" potency +9','DEX+7','"Mag.Atk.Bns."+14',}}
	gear.merlin_body_aspir 		= { name="Merlinic Jubbah", augments={'"Drain" and "Aspir" potency +9','CHR+1','"Mag.Atk.Bns."+4',}}
	gear.merlin_feet_aspir 		= { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +9',}}

	gear.chironic_head_curepot 	= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}
	gear.chironic_head_mnd 		= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}

	gear.chironic_hands_macc 	= { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','MND+8','Mag. Acc.+3','"Mag.Atk.Bns."+7',}}
	gear.chironic_legs_macc 	= { name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Resist Silence"+3','INT+4','Mag. Acc.+14',}}

	gear.chironic_feet_refresh 	= { name="Chironic Slippers", augments={'Pet: DEX+12','Damage taken-3%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.chironic_hands_refresh = { name="Chironic Gloves", augments={'STR+9','Pet: Mag. Acc.+10','"Refresh"+2','Accuracy+18 Attack+18',}}
	
	gear.valorous_head_wsd 	= {	name="Valorous Mask", augments={'Accuracy+23','Weapon skill damage +3%','STR+13','Attack+13',}}
	gear.valorous_hands_wsd = { name="Valorous Mitts", augments={'Weapon skill damage +4%','STR+14','Attack+11',}}
	gear.valorous_feet_wsd	= { name="Valorous Greaves", augments={'Accuracy+22','Weapon skill damage +3%','STR+12','Attack+9',}}

	gear.valorous_body_tp 	= { name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+6','AGI+3','Accuracy+12','Attack+4',}}
	gear.valorous_feet_qa 	= { name="Valorous Greaves", augments={'Accuracy+10 Attack+10','"Fast Cast"+1','Quadruple Attack +3','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
	
	gear.valorous_hands_cdmg 	= { name="Valorous Mitts", augments={'Accuracy+11','Crit. hit damage +3%','STR+9',}}
	gear.valorous_feet_cdmg 	= { name="Valorous Greaves", augments={'Attack+16','Crit. hit damage +2%','STR+9','Accuracy+10',}}

	gear.odyssean_feet_fc 		 = { name="Odyssean Greaves", augments={'Pet: Accuracy+7 Pet: Rng. Acc.+7','"Mag.Atk.Bns."+7','"Fast Cast"+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.odyssean_feet_refresh 	 = { name="Odyssean Greaves", augments={'INT+2','Rng.Atk.+25','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.odyssean_hands_upheaval = { name="Odyssean Gauntlets", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','VIT+6','Accuracy+11',}}
	
	gear.herc_legs_mabwsd 	= { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +3%','INT+1','Mag. Acc.+14',}}
	gear.herc_legs_sbwsd 	= { name="Herculean Trousers", augments={'Weapon skill damage +3%','STR+14','Accuracy+14','Attack+13',}}
	gear.herc_head_mabwsd 	= { name="Herculean Helm", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Weapon skill damage +2%','AGI+5','Mag. Acc.+10','"Mag.Atk.Bns."+7',}}
	gear.herc_head_sbwsd 	= { name="Herculean Helm", augments={'Attack+29','Weapon skill damage +4%','Accuracy+4',}}
	gear.herc_feet_cchance 	= { name="Herculean Boots", augments={'Accuracy+14 Attack+14','Crit.hit rate+4','Accuracy+5','Attack+13',}}
	gear.herc_feet_ta 		= { name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','STR+9','Accuracy+15','Attack+8',}}

	-- Weapons
	gear.grio_enfeeble		= { name="Grioavolr", augments={'Enfb.mag. skill +13','MND+20','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}
	gear.colada_enhdur		= { name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+2','"Mag.Atk.Bns."+1',}}

	-- Crafting
	sets.crafting_skillup = {head="Midras's Helm +1",ring1="Craftkeeper's Ring",ring2="Artificer's Ring"}
	sets.crafting_hq = set_combine(sets.crafting_skillup, {ring1="Craftmaster's Ring"})

end
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	sets.reive = {neck="Arciela's Grace +1"}
end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end