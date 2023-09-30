extends Control


var beds: Array[Bed]

@onready var current_bed: Bed = %Bed1


func _ready() -> void:
	beds.append(%Bed1)
	beds.append(%Bed2)
	beds.append(%Bed3)
	beds.append(%Bed4)
	beds.append(%Bed5)
	
	Events.character_selected.connect(character_selected)
	Events.show_text.connect(show_text)
	
	# start with 1 selected
	character_selected(%Bed1.character, %Bed1)


func character_selected(character: Character, bed: Bed) -> void:
	%CharacterImage.texture = character.image
	current_bed = bed
	
	for child in %ActionContainer.get_children():
		child.queue_free()
	
	for action: Action in character.actions:
		var button := Button.new()
		%ActionContainer.add_child(button)
		button.text = action.name
		button.pressed.connect(on_action_button_pressed.bind(action, bed))


func show_text(text: String) -> void:
	%Textbox.add_text("\n" + text)


func on_action_button_pressed(action: Action, bed: Bed) -> void:
	bed.set_action(action)


func _on_progress_button_pressed() -> void:
	%PhaseManager.advance_phase(beds)
