class_name Bed
extends Control
# Character slot


## Character inside this bed at start
@export var character: Character
## If built already at start
@export var built: bool = true

## If built and empty
var available: bool:
	get:
		return built and character == null

## If built and empty
var character_unoccupied: bool:
	get:
		return built and character != null and current_action == null

var current_action: RestAction


func _ready() -> void:
	update_character()
	
	if not built:
		%BuildPanel.show()


func update_character() -> void:
	if character == null:
		%EmptyPanel.show()
		return
	
	%EmptyPanel.hide()
	%Portrait.texture = character.portrait
	%NameLabel.text = character.name
	%HungerLabel.text = str(character.hunger)
	#%ThirstLabel.text = str(character.thirst)
	
	# set actions
	%ActionsDropdown.clear()
	actions.clear()
	
	%ActionsDropdown.add_item("Actions")
	%ActionsDropdown.set_item_disabled(0, true)
	%ActionsDropdown.add_separator()
	var default_action := RestAction.new()
	%ActionsDropdown.add_item(default_action.name)
	actions[default_action.name] = default_action
	
	for action: RestAction in character.actions:
		%ActionsDropdown.add_item(action.name)
		actions[action.name] = action


var actions: Dictionary

func set_action(action: RestAction) -> void:
	%ActionPanel.show()
	%ActionLabel.text = action.name
	%ActionProgress.max_value = action.duration
	%ActionProgress.value = 0
	current_action = action


func advance_action() -> void:
	if current_action == null:
		return
	
	%ActionProgress.value += 1
	if %ActionProgress.value >= %ActionProgress.max_value:
		# action finished
		%ActionPanel.hide()
		current_action.process_finished()
		current_action = null


func _on_gui_input(event: InputEvent) -> void:
	if event.is_pressed() and event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				Events.character_selected.emit(character, self)
			
			MOUSE_BUTTON_RIGHT:
				pass
			
			MOUSE_BUTTON_MIDDLE:
				pass


func _on_build_button_pressed() -> void:
	if Globals.wood < 100:
		Events.show_text.emit("Not enough wood", Color.DARK_RED)
		return
	
	Globals.wood -= 100
	
	%BuildPanel.hide()
	built = true


func _on_actions_dropdown_item_selected(index: int) -> void:
	var action_name = %ActionsDropdown.get_item_text(index)
	
	set_action(actions[action_name])
	
	# advance phase if all characters are occupied
	Events.advance_phase.emit()
