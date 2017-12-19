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
	
	
	-- Reisenjima
	gear.merlin_feet_fc ={ name="Merlinic Crackows", augments={'Mag. Acc.+10 "Mag.Atk.Bns."+10','"Fast Cast"+5','MND+2','Mag. Acc.+12','"Mag.Atk.Bns."+9'}}
	gear.merlin_head_fc = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','"Fast Cast"+5','Mag. Acc.+2',}}
	gear.merlin_head_mbd = { name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+8%','"Mag.Atk.Bns."+14',}}
	gear.merlin_legs_mab = { name="Merlinic Shalwar", augments={'Mag. Acc.+20','Magic burst dmg.+9%','INT+3',}}
	gear.chironic_head_curepot = { name="Chironic Hat", augments={'Accuracy+16','"Cure" potency +9%','Mag. Acc.+15','"Mag.Atk.Bns."+7'}}
	gear.chironic_hands_macc = { name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','MND+8','Mag. Acc.+3','"Mag.Atk.Bns."+7',}}
	gear.chironic_pants_macc = { name="Chironic Hose", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Fast Cast"+3','CHR+3','Mag. Acc.+13','"Mag.Atk.Bns."+2',}}
	gear.chironic_feet_refresh = { name="Chironic Slippers", augments={'Pet: DEX+12','Damage taken-3%','"Refresh"+2','Accuracy+9 Attack+9','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.chironic_hands_refresh = { name="Chironic Gloves", augments={'STR+9','Pet: Mag. Acc.+10','"Refresh"+2','Accuracy+18 Attack+18',}}
	gear.valorous_hands_wsd = { name="Valorous Mitts", augments={'Accuracy+21','Weapon skill damage +3%','DEX+2','Attack+5',}}
	gear.odyssean_feet_fc = { name="Odyssean Greaves", augments={'Pet: Accuracy+7 Pet: Rng. Acc.+7','"Mag.Atk.Bns."+7','"Fast Cast"+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.odyssean_feet_refresh = { name="Odyssean Greaves", augments={'INT+2','Rng.Atk.+25','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}


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
end

