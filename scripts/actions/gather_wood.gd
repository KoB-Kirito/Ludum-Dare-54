class_name GatherWood
extends Action


## Amount this character can collect
@export var amount: int = 1


func _init() -> void:
	name = "Gather Wood"
	duration = 3


func process_finished() -> void:
	Events.wood_collected.emit(amount)
