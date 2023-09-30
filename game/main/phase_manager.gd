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

@export var current_phase: int = NOON


func advance_phase(beds: Array[Bed]) -> void:
	for bed: Bed in beds:
		bed.advance_action()
	
	current_phase += 1
	if current_phase > NIGHT:
		current_phase = MORNING
	
	set_background(current_phase)
	
	# TODO: Events


func set_background(phase) -> void:
	match phase:
		MORNING:
			%ShelterBackground.texture = morning_background
			%PhaseLabel.text = "Morning"
			%Textbox.add_text("\nMorning")
		
		NOON:
			%ShelterBackground.texture = noon_background
			%PhaseLabel.text = "Noon"
			%Textbox.add_text("\nNoon")
		
		AFTERNOON:
			%ShelterBackground.texture = afternoon_background
			%PhaseLabel.text = "Afternoon"
			%Textbox.add_text("\nAfternoon")
		
		EVENING:
			%ShelterBackground.texture = evening_background
			%PhaseLabel.text = "Evening"
			%Textbox.add_text("\nEvening")
		
		NIGHT:
			%ShelterBackground.texture = night_background
			%PhaseLabel.text = "Night"
			%Textbox.add_text("\nNight")
