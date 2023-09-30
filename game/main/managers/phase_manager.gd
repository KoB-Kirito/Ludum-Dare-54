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

var beds: Array[Bed]


func _ready() -> void:
	beds.append(%Bed1)
	beds.append(%Bed2)
	beds.append(%Bed3)
	beds.append(%Bed4)
	beds.append(%Bed5)


func advance_phase() -> void:
	# only advance if all characters are occupied
	for bed: Bed in beds:
		if bed.character_unoccupied:
			return
	
	for bed: Bed in beds:
		bed.advance_action()
	
	current_phase += 1
	if current_phase > NIGHT:
		current_phase = MORNING
	
	set_background(current_phase)
	
	if current_phase == MORNING:
		%snd_rooster.play()
		Events.show_text.emit("A new day is dawning...", Color.YELLOW)
	
	# TODO: Events
	# check events
	# trigger events
	# break
	
	# auto-advance if still occupied
	for bed: Bed in beds:
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
