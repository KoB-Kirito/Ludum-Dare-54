class_name CharacterManager
extends Node


@export var characters: Array[Character]


## Returns a random character and removes that character from the database
## so it does not get picked again.
## Returns null if database is empty
func get_random_character() -> Character:
	if characters.size() == 0:
		return null
	
	var output = characters.pick_random()
	characters.erase(output)
	
	return output


func get_character(character_name: String) -> Character:
	if characters.is_empty():
		return null
	
	for character: Character in characters:
		if character.name.to_lower() == character_name.to_lower():
			characters.erase(character)
			return character
	
	print_debug("character not found: " + character_name)
	return null
