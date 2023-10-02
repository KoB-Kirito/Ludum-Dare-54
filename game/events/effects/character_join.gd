class_name CharacterJoinEffect
extends Effect

## Name of character. Will pick random if empty
@export var character: String


func process() -> void:
	if character != null and not character.is_empty():
		Globals.main.add_character(Globals.character_manager.get_random_character())
		
	else:
		Globals.main.add_character(Globals.character_manager.get_character(character))
