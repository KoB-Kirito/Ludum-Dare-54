extends Node2D


@onready var background_5: Sprite2D = $Background5
@onready var background_6: Sprite2D = $Background6
@onready var snow: GPUParticles2D = $Snow


func change_background(phase: Globals.Phase) -> void:
	
	print("background changes to " + str(phase))
	
	# TODO
	match phase:
		Globals.Phase.MORNING:
			$Morning.show()
			$Noon.hide()
			$Evening.hide()
			$Night.hide()
			$Snow.show()
			$Night/Snow_intro.hide()
			$Night/Snow_Night.hide()
			$Smoke.hide()
			pass
		
		Globals.Phase.NOON:
			$Morning.hide()
			$Noon.show()
			$Evening.hide()
			$Night.hide()
			$Snow.hide()
			$Night/Snow_intro.hide()
			$Night/Snow_Night.hide()
			$Smoke.hide()
			pass
		
		Globals.Phase.EVENING:
			$Morning.hide()
			$Noon.hide()
			$Evening.show()
			$Night.hide()
			$Snow.show()
			$Night/Snow_intro.hide()
			$Night/Snow_Night.hide()
			$Smoke.show()
			pass
		
		Globals.Phase.NIGHT:
			$Morning.hide()
			$Noon.hide()
			$Evening.hide()
			$Night.show()
			$Snow.show()
			$Night/Snow_intro.hide()
			$Night/Snow_Night.show()
			$Smoke.show()
			pass
