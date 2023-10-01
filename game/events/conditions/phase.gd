class_name PhaseCondition
extends Condition


## Name of character that has to be present
@export var character_name: String


func is_met() -> bool:
	for bed: Bed in Globals.beds:
		if bed.character != null and bed.character.name == character_name:
			return true
	
	return false
