extends Control


@export_file("*.tscn") var main_scene: String
@export_file("*.tscn") var credits_scene: String


func _ready() -> void:
	pass
	# TODO: controller support
	#$VBoxContainer/StartButton.grab_focus()


func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file(main_scene)
	
	# start level 1


func _on_button_2_pressed() -> void:
	pass
	
	# show options


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file(credits_scene)
