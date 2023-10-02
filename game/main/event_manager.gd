class_name EventManager
extends Node


signal events_finished


@export var events: Array[Event]


func trigger_random_event() -> void:
	var valid_events := get_valid_events()
	
	valid_events.shuffle()
	
	# always trigger 100
	for event: Event in valid_events:
		if event.weight == 100:
			trigger_event(event)
			break
	
	var weighted_events := get_weighted_events(valid_events)
	var r: int = randi() % 100
	
	if weighted_events.size() < r:
		# no event
		print_debug("no event picked. r was " + str(r) + " and weighted array was " + str(weighted_events.size()))
		return
	
	trigger_event(weighted_events[r])


func get_valid_events() -> Array[Event]:
	var output: Array[Event]
	for event: Event in events:
		var all_conditions_met: bool = true
		for condition: Condition in event.conditions:
			if condition == null:
				print_debug("condition is null")
				continue
			
			if not condition.has_method("is_met"):
				print_debug("condition is missing is_met method: " + str(condition))
				continue
			
			if not condition.is_met():
				all_conditions_met = false
				break
		if all_conditions_met:
			output.append(event)
	return output


func get_weighted_events(v_events: Array[Event]) -> Array[Event]:
	var output: Array[Event]
	for event: Event in v_events:
		for i in range(event.weight):
			output.append(event)
	return output


## Returns a random event that matches all conditions
## Returns null if empty or none matches conditions
func get_random_event() -> Event:
	if events.is_empty():
		print_debug("event list is empty")
		return null
	
	events.shuffle()
	
	for event: Event in events:
		for condition: Condition in event.conditions:
			if condition == null:
				continue
			
			if not condition.has_method("is_met"):
				print_debug("condition is missing is_met method: " + str(condition))
				continue
			
			if not condition.is_met():
				continue
		return event
	
	print_debug("no event matches conditions")
	return null


func trigger_event(event: Event) -> void:
	if event == null:
		print_debug("event was null")
		return
	
	# show event layer > dims screen, disables all inputs
	%EventLayer.show()
	
	# show image if set
	if event.image == null:
		%EventImage.hide()
	else:
		%EventImage.show()
		%EventImage.texture = event.image
	
	# display text
	if not event.text.is_empty():
		Events.show_text.emit(event.text)
	
	# display choices
	var selectable_choice_added: bool = false
	for child in %ChoicesContainer.get_children():
		child.queue_free()
	for choice: Choice in event.choices:
		if choice == null:
			continue
		
		var choice_button := Button.new()
		%ChoicesContainer.add_child(choice_button)
		choice_button.text = choice.text
		
		var conditions_met: bool = true
		var fail_text: String = ""
		for condition: Condition in choice.conditions:
			if not condition.is_met():
				conditions_met = false
				fail_text = condition.fail_text
		
		if conditions_met:
			choice_button.pressed.connect(on_choice_selected.bind(choice.effects))
			selectable_choice_added = true
			
		else:
			# not all conditions met
			if fail_text.is_empty():
				choice_button.queue_free()
			else:
				# show unavailable
				choice_button.text += " [" + fail_text + "]" 
				choice_button.disabled
				choice_button.add_theme_color_override("font_color", Color.RED)
	
	# catch empty choices
	if not selectable_choice_added:
		var choice_button := Button.new()
		%ChoicesContainer.add_child(choice_button)
		choice_button.text = "Ok"
		var empty: Array[Effect] = []
		choice_button.pressed.connect(on_choice_selected.bind(empty))


func on_choice_selected(effects: Array[Effect]) -> void:
	if effects != null and effects.size() > 0:
		for effect: Effect in effects:
			if effect is ChainEventEffect:
				trigger_event(effect.event)
				return
			
			effect.process()
	
	close_event()


func close_event() -> void:
	%EventLayer.hide()
	%Notebook.scroll_out()
	events_finished.emit()
