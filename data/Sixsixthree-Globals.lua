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

	
	sets.reive = {neck="Adoulin's Refuge +1"}
	sets.warp_ring = {ring2="Warp Ring"}
------------------------------------------------------------------------------

	-- Skirmish

	-- Pet: -DT (37.5% to cap)
	-- Duskorb: pet dt -4
	-- Leaforb: pet regen +3
	-- Leaftip: 4
	-- Dukstip: 4

  	gear.telchine_head_pet_dt 	= { name="Telchine Cap", augments={'Pet: "Regen"+1','Pet: Damage taken -4%',}}
	gear.telchine_body_pet_dt	= { name="Telchine Chas.", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}}
	gear.telchine_legs_pet_dt	= { name="Telchine Braconi", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}}
	gear.telchine_feet_pet_dt	= { name="Telchine Pigaches", augments={'Pet: "Regen"+1','Pet: Damage taken -3%',}}

	gear.telchine_head_enh_dur 	= { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_body_enh_dur 	= { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_hands_enh_dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	gear.telchine_legs_enh_dur 	= { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}}
	gear.telchine_feet_enh_dur 	= { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +8',}}

	gear.telchine_feet_song_fc 	= {name="Telchine Pigaches", augments={'Song spellcasting time -5%',}}

	gear.taeon_head_snap 		= { name="Taeon Chapeau", augments={'"Snapshot"+4','"Snapshot"+4',}}

	-- Reisenjima
	gear.merlinic_head_fc = { name="Merlinic Hood", augments={'"Fast Cast"+6','DEX+11','Accuracy+2 Attack+2',}}
	gear.merlinic_hands_fc= { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','Mag. Acc.+9',}}
	gear.merlinic_feet_fc = { name="Merlinic Crackows", augments={'Mag. Acc.+30','"Fast Cast"+6',}}
	gear.merlinic_head_refresh = { name="Merlinic Hood", augments={'MND+8','Pet: Accuracy+25 Pet: Rng. Acc.+25','"Refresh"+2','Accuracy+7 Attack+7',}}
	gear.merlinic_feet_refresh = { name="Merlinic Crackows", augments={'AGI+7','Accuracy+22 Attack+22','"Refresh"+1',}}

	gear.herc_legs_mab = 	{ name="Herculean Trousers", augments={'Accuracy+27','"Mag.Atk.Bns."+14','Accuracy+15 Attack+15','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}
	gear.herc_feet_mab =	{	name="Herculean Boots", augments={'DEX+9','STR+14','Damage taken-3%','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)

end
 
-----------------------------------------------------------
-- Test function to use to avoid modifying library files.
-----------------------------------------------------------
 
function user_test(params)
 
end