class_name Main
extends Control


func _ready() -> void:
	# store beds globally
	Globals.beds.append(%Bed1)
	Globals.beds.append(%Bed2)
	Globals.beds.append(%Bed3)
	Globals.beds.append(%Bed4)
	Globals.beds.append(%Bed5)
	
	Globals.character_manager = %CharacterManager
	Globals.main = self
	
	Events.character_selected.connect(character_selected)
	
	add_character(%CharacterManager.get_random_character())
	add_character(%CharacterManager.get_random_character())


func add_character(character: Character) -> void:
	if character == null:
		return
	
	var bed_found: bool = false
	for bed: Bed in Globals.beds:
		if bed.available:
			bed.character = character
			bed.update_character()
			bed_found = true
			break
	
	if bed_found:
		Events.show_text.emit(character.name + " joined your group", Color.GREEN)
	else:
		Events.show_text.emit("You sent " + character.name + " away, because you had no bed available..", Color.RED)


func character_selected(character: Character, bed: Bed) -> void:
	%TopRightBackground.show()
	%CharacterImage.texture = character.image
	%DescriptionLabel.text = character.description
	
	%HideCharacterTimer.start()


func _on_hide_character_timer_timeout() -> void:
	%TopRightBackground.hide()
