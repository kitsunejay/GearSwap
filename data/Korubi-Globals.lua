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

	
    sets.reive = {neck="Arciela's Grace +1"}
	sets.warp_ring = {ring2="Warp Ring"}

	------------------------------------------------------------------------------

	-- Skirmish

	-- snowslit - 20/20 acc/attk or 25acc
	-- dusktip - 7dex/7str or 10dex
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
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}
	

	gear.taeon_head_phalanx		= { name="Taeon Chapeau", augments={'Mag. Evasion+7','Spell interruption rate down -9%','Phalanx +3',}}
	gear.taeon_body_phalanx 	= { name="Taeon Tabard", augments={'Mag. Evasion+20','Spell interruption rate down -8%','Phalanx +3',}}
    gear.taeon_hands_phalanx	= { name="Taeon Gloves", augments={'Mag. Evasion+11','Spell interruption rate down -7%','Phalanx +3',}}
    gear.taeon_legs_phalanx		= { name="Taeon Tights", augments={'Evasion+19','Spell interruption rate down -10%','Phalanx +3',}}
	gear.taeon_feet_phalanx		= { name="Taeon Boots", augments={'Mag. Evasion+20','Spell interruption rate down -9%','Phalanx +3',}}
	

	gear.taeon_head_ta			= { name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','STR+5 DEX+5',}}
    gear.taeon_hands_ta			= { name="Taeon Gloves", augments={'Accuracy+24','"Triple Atk."+2','STR+7 DEX+7',}}
	gear.taeon_legs_ta			= { name="Taeon Tights", augments={'Accuracy+18 Attack+18','"Triple Atk."+2','DEX+8',}}
	gear.taeon_feet_dw			= { name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','STR+6 DEX+6',}}

	gear.taeon_head_snap 		= { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}

	------------------------------------------------------------------------------

	-- Ru'an

	-- Reisenjima
	gear.merlin_head_fc  = 	{ name="Merlinic Hood", augments={'"Fast Cast"+7','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
	--gear.merlin_body_fc =	{ name="Merlinic Jubbah", augments={'"Fast Cast"+7',}} --mule'd
	gear.merlin_hands_fc = 	{ name="Merlinic Dastanas", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+7','INT+6',}}
	gear.merlin_feet_fc  = 	{ name="Merlinic Crackows", augments={'Mag. Acc.+16','"Fast Cast"+7',}}

	gear.merlin_head_mbd = 	{ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','"Mag.Atk.Bns."+14',}}
	gear.merlin_body_mbd = 	{ name="Merlinic Jubbah", augments={'Magic burst dmg.+11%','"Mag.Atk.Bns."+15',}}
	gear.merlin_legs_mbd = 	{ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+9%','MND+5','Mag. Acc.+4','"Mag.Atk.Bns."+5',}}
	gear.merlin_feet_mbd =  { name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+8%','INT+14','Mag. Acc.+14',}}

	gear.merlin_legs_mab =  { name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-2','INT+8','"Mag.Atk.Bns."+8',}}
	gear.merlin_feet_mab = 	{ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+9','Mag. Acc.+7','"Mag.Atk.Bns."+15',}}

	gear.merlin_hands_aspir 	= { name="Merlinic Dastanas", augments={'Mag. Acc.+30','"Drain" and "Aspir" potency +9','DEX+7','"Mag.Atk.Bns."+14',}}
	gear.merlin_body_aspir 		= { name="Merlinic Jubbah", augments={'"Drain" and "Aspir" potency +9','CHR+1','"Mag.Atk.Bns."+4',}}
	--gear.merlin_feet_aspir 		= { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +9',}} --mule'd

	-- Phys
	--bpd10 27attk 7str

	-- Magic
	--bpd8  17mab 8macc

	gear.chironic_head_curepot 	= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}
	gear.chironic_head_mnd 		= { name="Chironic Hat", augments={'"Mag.Atk.Bns."+24','"Resist Silence"+4','MND+10','Mag. Acc.+11',}}

	gear.chironic_hands_macc 	= { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','MND+8','Mag. Acc.+3','"Mag.Atk.Bns."+7',}}
	gear.chironic_legs_macc 	= { name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Resist Silence"+3','INT+4','Mag. Acc.+14',}}

	gear.chironic_feet_refresh 	= { name="Chironic Slippers", augments={'Pet: DEX+12','Damage taken-3%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.chironic_hands_refresh = { name="Chironic Gloves", augments={'STR+9','Pet: Mag. Acc.+10','"Refresh"+2','Accuracy+18 Attack+18',}}
	
	gear.valorous_head_wsd 	= {	name="Valorous Mask", augments={'Accuracy+23','Weapon skill damage +3%','STR+13','Attack+13',}}
	gear.valorous_hands_wsd = { name="Valorous Mitts", augments={'Accuracy+25','Weapon skill damage +4%','STR+13',}}
	gear.valorous_feet_wsd	= { name="Valorous Greaves", augments={'Accuracy+22','Weapon skill damage +3%','STR+12','Attack+9',}}

	gear.valorous_body_stp 	= { name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+6','AGI+3','Accuracy+12','Attack+4',}}
	gear.valorous_body_da	= { name="Valorous Mail", augments={'Accuracy+5 Attack+5','"Dbl.Atk."+5','DEX+10','Accuracy+13',}}
	gear.valorous_feet_qa 	= { name="Valorous Greaves", augments={'Accuracy+10 Attack+10','"Fast Cast"+1','Quadruple Attack +3','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
	
	gear.valorous_head_cdmg		= { name="Valorous Mask", augments={'Accuracy+7','Crit. hit damage +3%','STR+11','Attack+13',}}
	gear.valorous_hands_cdmg 	= { name="Valorous Mitts", augments={'Accuracy+6 Attack+6','Crit. hit damage +3%','STR+12','Accuracy+8',}}
	gear.valorous_feet_cdmg 	= { name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Crit. hit damage +4%','STR+11',}}
	gear.valorous_body_cdmg		= { name="Valorous Mail", augments={'Crit. hit damage +3%','STR+10','Accuracy+11','Attack+12',}}
	--gear.valorous_legs_cdmg		= { name="Valor. Hose", augments={'Attack+12','Crit. hit damage +2%','STR+11','Accuracy+9',}} -- mule'd

	gear.odyssean_feet_fc 		 = { name="Odyssean Greaves", augments={'Pet: Accuracy+7 Pet: Rng. Acc.+7','"Mag.Atk.Bns."+7','"Fast Cast"+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.odyssean_feet_refresh 	 = { name="Odyssean Greaves", augments={'INT+2','Rng.Atk.+25','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.odyssean_hands_wsd 	 = { name="Odyssean Gauntlets", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','VIT+6','Accuracy+11',}}
	

	gear.herc_feet_ta 		= { name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','STR+9','Accuracy+15','Attack+8',}}
	gear.herc_feet_cdmg 	= { name="Herculean Boots", augments={'Accuracy+7','Crit. hit damage +4%','STR+14','Attack+5',}}
	gear.herc_feet_multi	= { name="Herculean Boots", augments={'"Dbl.Atk."+2','Attack+3','Quadruple Attack +2','Accuracy+17 Attack+17',}}

	--gear.herc_legs_mabwsd 	= { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +3%','INT+1','Mag. Acc.+14',}}
	gear.herc_head_mabwsd 	= { name="Herculean Helm", augments={'"Rapid Shot"+7','Mag. Acc.+24 "Mag.Atk.Bns."+24','"Refresh"+2',}}
	gear.herc_legs_mabwsd   = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Mag. Acc.+3','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	
	gear.herc_head_sbwsd 	= { name="Herculean Helm", augments={'STR+9','Pet: "Mag.Atk.Bns."+29','Weapon skill damage +5%','Accuracy+19 Attack+19','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
	gear.herc_legs_sbwsd 	= { name="Herculean Trousers", augments={'Weapon skill damage +3%','STR+14','Accuracy+14','Attack+13',}}
	gear.herc_head_wsd 		= { name="Herculean Helm", augments={'Accuracy+28','Weapon skill damage +4%','DEX+8','Attack+13',}}

	gear.herc_feet_cchance 	= { name="Herculean Boots", augments={'Accuracy+14 Attack+14','Crit.hit rate+4','Accuracy+5','Attack+13',}}

	gear.herc_body_phalanx	= { name="Herculean Vest", augments={'Haste+3','CHR+9','Phalanx +4','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	gear.herc_hands_phalanx = { name="Herculean Gloves", augments={'"Mag.Atk.Bns."+6','DEX+4','Phalanx +4',}}
	gear.herc_legs_phalanx 	= { name="Herculean Trousers", augments={'Attack+15','Pet: Attack+26 Pet: Rng.Atk.+26','Phalanx +5',}}

	gear.herc_hands_th 		= { name="Herculean Gloves", augments={'Pet: INT+6','"Mag.Atk.Bns."+19','"Treasure Hunter"+2','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}

	------------------------------------------------------------------------------
	--  JSE Capes
    ------------------------------------------------------------------------------
	
	-- Ambuscade Capes
	
	-- BLM
	gear.bane_mp 		={ name="Bane Cape", augments={'"Mag. Atk. Bns." +1', 'Elem. Magic Skill +4', 'Dark Magic Skill +10'}}
	gear.taranus_mab 	={ name="Taranus's Cape", augments={'"Mag. Atk. Bns." +10','Mag. Acc. +20/Mag. Dmg. +20','INT +10', 'INT +20'}}
    gear.taranus_fc 	={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	
	-- BLU
	gear.rosmertas_cdc  = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
    gear.rosmertas_tp   = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.rosmertas_mab  = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	gear.rosmertas_wsd  = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	-- COR
    gear.camulus_wsd     = {  name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    gear.camulus_mwsd    = {  name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    gear.camulus_tp      = {  name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}} --needle?
    gear.camulus_snap    = {  name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10',}} --finish
    gear.camulus_savageb = {  name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} -- resin
    gear.camulus_dw      = {  name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
    gear.camulus_da      = {  name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	
	-- DRG
	gear.brigantias_da   = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.brigantias_wsd	 = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.brigantias_tp	 = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	
	-- MNK
	gear.segomo_da		 = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.segomo_crit	 = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
	gear.segomo_dexda	 = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
    gear.segomo_tp		 = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}}
	gear.segomo_wsd    	 = { name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	-- PLD
	gear.rudianos_enmity = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}}

	-- RDM
    gear.ghostfyre ={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +8','Mag. Acc.+9','Enh. Mag. eff. dur. +19',}}
    gear.sucellos_macc ={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity-10',}} 
    gear.sucellos_mab  ={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    gear.sucellos_dw   ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.sucellos_wsd  ={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.sucellos_cdc  ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	
	-- RUN
    gear.ogma_tp =      { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.ogma_enmtiy=   { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
    gear.ogma_parry =   { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.ogma_fc    =   { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
    gear.ogma_ws  =     { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10'}} --resin
    gear.ogma_dimid =   { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	-- SAM
    gear.smertrios_wsd 	={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.smertrios_tp   ={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	
	-- SCH
    gear.lugh_fc    =  { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}}
	gear.lugh_mab   =  { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	
	-- SMN
	gear.campestres_magic 	= { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Mag. Acc+20 /Mag. Dmg.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}}
	gear.campestres_phys 	= { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10',}}
	gear.campestres_fc 		= gear.campestres_magic
	gear.campestres_macc 	= gear.campestres_magic

	-- THF
	gear.toutatis_wsd  = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.toutatis_tp   = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.toutatis_crit = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
            
	-- WAR
    gear.cichol_ws          = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}} -- resin
    gear.cichol_upheaval    = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	gear.cichol_tp          = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	
	-- WHM
	
	------------------------------------------------------------------------------

	-- Weapons
	gear.grio_enfeeble		= { name="Grioavolr", augments={'Enfb.mag. skill +13','MND+20','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}
	gear.grio_pet_magic		= { name="Grioavolr", augments={'Enfb.mag. skill +13','MND+20','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}

	gear.colada_enhdur		= { name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+2','"Mag.Atk.Bns."+1',}}

	------------------------------------------------------------------------------

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