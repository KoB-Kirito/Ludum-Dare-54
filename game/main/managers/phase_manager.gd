class_name PhaseManager
extends Node


@export var morning_background: Texture2D
@export var noon_background: Texture2D
@export var afternoon_background: Texture2D
@export var evening_background: Texture2D
@export var night_background: Texture2D

## Starting phase
@export var start_phase: int = Globals.Phase.NOON


func advance_phase() -> void:
	# only advance if all characters are occupied
	for bed: Bed in Globals.beds:
		if bed.character_unoccupied:
			return
	
	for bed: Bed in Globals.beds:
		bed.advance_action()
	
	Globals.current_phase += 1
	if Globals.current_phase > Globals.Phase.NIGHT:
		Globals.current_phase = Globals.Phase.MORNING
	
	%DayProgress.value = Globals.current_phase
	set_background(Globals.current_phase)
	Background.change_background(Globals.current_phase)
	
	if Globals.current_phase == Globals.Phase.MORNING:
		%snd_rooster.play()
		Events.show_text.emit("A new day is dawning...", Color.YELLOW)
	
	# test
	if randi() % 2 == 0:
		%EventManager.trigger_random_event()
	
	# TODO: put character appears in events
	if randi() % 4 == 0:
		var new_character = %CharacterManager.get_random_character()
		if new_character != null:
			Events.show_text.emit("A new character appeared! (choices follor..)", Color.FUCHSIA)
			var bed_found: bool = false
			for bed: Bed in Globals.beds:
				if bed.available:
					bed.character = new_character
					bed.update_character()
					bed_found = true
					break
			
			if bed_found:
				Events.show_text.emit(new_character.name + " joins your group", Color.GREEN)
			else:
				Events.show_text.emit("You sent " + new_character.name + " away, because you had no bed available..", Color.RED)


func on_events_finished() -> void:
	# auto-advance if still occupied
	for bed: Bed in Globals.beds:
		if bed.character_unoccupied:
			return
	%AutoAdvanceTimer.start()


func set_background(phase) -> void:
	match phase:
		Globals.Phase.MORNING:
			Events.show_text.emit("Morning")
		
		Globals.Phase.NOON:
			Events.show_text.emit("Noon")
		
		Globals.Phase.EVENING:
			Events.show_text.emit("Evening")
		
		Globals.Phase.NIGHT:
			Events.show_text.emit("Night")


func _on_auto_advance_timer_timeout() -> void:
	advance_phase()
