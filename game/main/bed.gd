class_name Bed
extends Control
# Character slot

## Character inside this bed at start
@export var character: Character
## If built already at start
@export var built: bool = true

@export_category("Ignore this <.<")
@export var default_actions: Array[RestAction]

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


func check_death() -> bool:
	if character.hunger <= 0:
		pass
	# TODO
	return false


func update_character() -> void:
	if character == null:
		%EmptyPanel.show()
		return
	
	if check_death():
		return
	
	%EmptyPanel.hide()
	%Portrait.texture = character.portrait
	%NameLabel.text = character.name
	
	%HungerLabel.text = str(character.hunger)
	%ThirstLabel.text = str(character.thirst)
	%SleepLabel.text = str(character.sleep)
	%HappynessLabel.text = str(character.happyness)
	
	# set actions
	%ActionsDropdown.clear()
	actions.clear()
	
	# default action
	%ActionsDropdown.add_item("Actions")
	%ActionsDropdown.set_item_disabled(0, true)
	%ActionsDropdown.add_separator()
	var default_action := RestAction.new()
	%ActionsDropdown.add_item(default_action.name)
	actions[default_action.name] = default_action
	
	for action: RestAction in character.actions:
		var conditions_met: bool = true
		var fail_text: String = ""
		for condition: Condition in action.conditions:
			if condition.is_met():
				conditions_met = false
				fail_text = condition.fail_text
		
		if conditions_met:
			%ActionsDropdown.add_item(action.name)
			actions[action.name] = action
			
		else:
			if fail_text != null and not fail_text.is_empty():
				%ActionsDropdown.add_item(action.name + " [" + fail_text + "]")
				%ActionsDropdown.set_item_disabled(%ActionsDropdown.size() - 1, true)


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
	
	# lower values
	character.hunger -= 1
	character.sleep -= 2
	character.happyness -= 1
	update_character()
	
	%ActionProgress.value += 1
	if %ActionProgress.value >= %ActionProgress.max_value:
		# action finished
		%ActionPanel.hide()
		current_action.process_finished()
		
		# default actions
		if current_action is Eat:
			character.hunger += 5
			if character.hunger >= character.hunger_max:
				character.hunger = character.hunger_max
			
		elif current_action is Drink:
			character.thirst += 5
			if character.thirst >= character.thirst_max:
				character.thirst = character.thirst_max
		
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
