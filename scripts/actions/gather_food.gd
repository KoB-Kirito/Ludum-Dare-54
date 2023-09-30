class_name GatherFood
extends Action


## Amount this character can collect
@export var amount: int = 1


func _init() -> void:
	name = "Gather Food"
	duration = 2


func process_finished() -> void:
	Events.food_collected.emit(amount)
