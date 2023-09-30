class_name ActionManager
extends Node


func _ready() -> void:
	Events.food_collected.connect(on_food_collected)
	Events.water_collected.connect(on_water_collected)
	Events.wood_collected.connect(on_wood_collected)


func on_food_collected(amount: int) -> void:
	Globals.food += amount
	Events.show_text.emit(str(amount) + " food collected")

func on_water_collected(amount: int) -> void:
	Globals.water += amount
	Events.show_text.emit(str(amount) + " water collected")

func on_wood_collected(amount: int) -> void:
	Globals.wood += amount
	Events.show_text.emit(str(amount) + " wood collected")
