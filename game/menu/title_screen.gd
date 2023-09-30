extends Control


@export_file("*.tscn") var main_menu: String


func _ready() -> void:
	pass
	
	# play music
	
	# play intro animation
	
	# button press cancels animation
	
	# afterwards > press any button to start
	
	# > main menu


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		get_tree().change_scene_to_file(main_menu)
