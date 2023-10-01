class_name EventManager
extends Node


@export var events: Array[Event]


func trigger_event(event: Event) -> void:
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
	for child in %ChoicesContainer.get_children():
		child.queue_free()
	for choice: Choice in event.choices:
		var choice_button := Button.new()
		%ChoicesContainer.add_child(choice_button)
		choice_button.text = choice.text
		choice_button.pressed.connect(on_choice_selected.bind(choice.effects))


func on_choice_selected(effects: Array[Effect]) -> void:
	for effect: Effect in effects:
		effect.process()
