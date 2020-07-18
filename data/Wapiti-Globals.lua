-----------------------------------------------------
-- Common gear across jobs for Wapiti
-----------------------------------------------------
function define_global_sets()
	-- Geomancer
	gear.staff = {}
	
	gear.head = {}
	gear.head.Vanya = {}
	gear.head.Vanya.HealingMagicSkill = {name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	
	gear.hands = {}
	gear.hands.Vanya = {}
	gear.hands.Vanya.HealingMagicSkill = {name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.hands.Amalric = {}
	gear.hands.Amalric.Nuke = {name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+19','"Mag.Atk.Bns."+19',}}
	
	gear.body = {}
	gear.body.Vanya = {}
	gear.body.Vanya.HealingMagicSkill = {name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	
	gear.legs = {}
	gear.legs.Merlinic = {}
	gear.legs.Merlinic.Nuke = {name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+24','"Store TP"+2','Accuracy+14 Attack+14','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	gear.legs.Amalric = {}
	gear.legs.Amalric.Nuke = {name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	
	gear.back = {}
	
	gear.feet = {}
	gear.feet.Vanya = {}
	gear.feet.Vanya.HealingMagicSkill = {name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.feet.Merlinic = {} 
	gear.feet.Merlinic.Refresh = {name="Merlinic Crackows", augments={'STR+3','Pet: MND+9','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	gear.feet.Merlinic.Nuke = gear.feet.Merlinic.Refresh
	gear.feet.Amalric = {}
	gear.feet.Amalric.Nuke = {name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}
end