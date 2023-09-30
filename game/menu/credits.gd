extends Node2D


@export_file("*.tscn") var main_menu_scene: String


func _ready() -> void:
	pass
	
	# animation or something?


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		get_tree().change_scene_to_file(main_menu_scene)
