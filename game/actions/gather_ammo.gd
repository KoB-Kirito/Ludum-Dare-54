class_name GatherAmmo
extends RestAction


## Amount this character can collect
@export var amount: int = 1


func _init() -> void:
	name = "Gather Ammo"
	duration = 3


func process_finished() -> void:
	Events.ammo_collected.emit(amount)
