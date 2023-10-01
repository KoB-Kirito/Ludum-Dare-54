class_name PhaseManager
extends Node


enum {
	MORNING,
	NOON,
	AFTERNOON,
	EVENING,
	NIGHT
}

@export var morning_background: Texture2D
@export var noon_background: Texture2D
@export var afternoon_background: Texture2D
@export var evening_background: Texture2D
@export var night_background: Texture2D

## Starting phase
@export var current_phase: int = NOON

@export var test_event: Event


func advance_phase() -> void:
	# only advance if all characters are occupied
	for bed: Bed in Globals.beds:
		if bed.character_unoccupied:
			return
	
	for bed: Bed in Globals.beds:
		bed.advance_action()
	
	current_phase += 1
	if current_phase > NIGHT:
		current_phase = MORNING
	
	%DayProgress.value = current_phase
	set_background(current_phase)
	
	if current_phase == MORNING:
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
		MORNING:
			%ShelterBackground.texture = morning_background
			Events.show_text.emit("Morning")
		
		NOON:
			%ShelterBackground.texture = noon_background
			Events.show_text.emit("Noon")
		
		AFTERNOON:
			%ShelterBackground.texture = afternoon_background
			Events.show_text.emit("Afternoon")
		
		EVENING:
			%ShelterBackground.texture = evening_background
			Events.show_text.emit("Evening")
		
		NIGHT:
			%ShelterBackground.texture = night_background
			Events.show_text.emit("Night")


func _on_auto_advance_timer_timeout() -> void:
	advance_phase()
