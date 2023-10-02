extends Control


@onready var current_bed: Bed = %Bed1

func _ready() -> void:
	# store beds globally
	Globals.beds.append(%Bed1)
	Globals.beds.append(%Bed2)
	Globals.beds.append(%Bed3)
	Globals.beds.append(%Bed4)
	Globals.beds.append(%Bed5)
	
	Events.character_selected.connect(character_selected)
	
	# start with 1 selected
	character_selected(%Bed1.character, %Bed1)


func character_selected(character: Character, bed: Bed) -> void:
	%TopRightBackground.show()
	%CharacterImage.texture = character.image
	current_bed = bed
	
	%HideCharacterTimer.start()


func _on_hide_character_timer_timeout() -> void:
	%TopRightBackground.hide()
