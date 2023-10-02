class_name PhaseManager
extends Node


@export var morning_background: Texture2D
@export var noon_background: Texture2D
@export var afternoon_background: Texture2D
@export var evening_background: Texture2D
@export var night_background: Texture2D

## Starting phase
@export var start_phase: Globals.Phase = Globals.Phase.NOON


func _ready() -> void:
	%EventManager.events_finished.connect(on_events_finished)
	Events.advance_phase.connect(advance_phase)


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
	
	#%DayProgress.value = Globals.current_phase
	set_background(Globals.current_phase)
	Background.change_background(Globals.current_phase)
	Music.change_music(Globals.current_phase)
	
	if Globals.current_phase == Globals.Phase.MORNING:
		%snd_rooster.play()
		Events.show_text.emit("A new day is dawning...", Color.YELLOW)
	
	%EventManager.trigger_random_event()


func on_events_finished() -> void:
	for bed: Bed in Globals.beds:
		bed.update_character()
	
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
