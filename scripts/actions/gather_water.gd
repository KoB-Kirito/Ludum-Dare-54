class_name GatherWater
extends Action


## Amount this character can collect
@export var amount: int = 1


func _init() -> void:
	name = "Gather Water"
	duration = 1


func process_finished() -> void:
	Events.water_collected.emit(amount)
