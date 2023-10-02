class_name ResourceCondition
extends Condition



@export_enum("Food", "Water", "Wood", "Medicine", "Ammo") var resource: int = 0
@export_enum("Greater", "Equal", "Smaller") var operator: int = 0
@export var amount: int = 0


func is_met() -> bool:
	match resource:
		0: # Food
			return check(Globals.food)
		
		1: # Water
			return check(Globals.water)
		
		2: # Wood
			return check(Globals.wood)
		
		3: # Medicine
			return check(Globals.medicine)
		
		4: # Ammo
			return check(Globals.ammo)
	return false


func check(v1: int) -> bool:
	match operator:
		0: # greater
			return v1 > amount
		
		1: # equal
			return v1 == amount
		
		2: # smaller
			return v1 < amount
	return false
