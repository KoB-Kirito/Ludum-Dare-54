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
	%CharacterImage.texture = character.image
	current_bed = bed
	
	for child in %ActionContainer.get_children():
		child.queue_free()
	
	for action: RestAction in character.actions:
		var button := Button.new()
		%ActionContainer.add_child(button)
		button.text = action.name
		button.pressed.connect(on_action_button_pressed.bind(action, bed))


func on_action_button_pressed(action: RestAction, bed: Bed) -> void:
	if bed.current_action != null:
		# action already active
		return
	
	bed.set_action(action)
	
	# advance phase if all characters are occupied
	%PhaseManager.advance_phase()
