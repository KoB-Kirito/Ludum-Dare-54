class_name CharacterPresentCondition
extends Condition


## Name of character that has to be present
@export var character_name: String


func is_met() -> bool:
	for bed: Bed in Globals.beds:
		if bed.character != null and bed.character.name.to_lower() == character_name.to_lower():
			return true
	
	return false
