extends Node2D


@onready var background_5: Sprite2D = $Background5
@onready var background_6: Sprite2D = $Background6
@onready var snow: GPUParticles2D = $Snow


func change_background(phase: Globals.Phase) -> void:
	
	print("background changes to " + str(phase))
	
	# TODO
	match phase:
		Globals.Phase.MORNING:
			pass
		
		Globals.Phase.NOON:
			pass
		
		Globals.Phase.EVENING:
			pass
		
		Globals.Phase.NIGHT:
			pass
