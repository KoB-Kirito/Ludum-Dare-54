class_name CharacterAvailableCondition
extends Condition


## Name of character that is still out there
@export var character_name: String


func is_met() -> bool:
	var character_in_database: bool = false
	for character: Character in Globals.character_manager.characters:
		if character.name.to_lower() == character_name.to_lower():
			character_in_database = true
			break
	
	if not character_in_database:
		return false
	
	return true
