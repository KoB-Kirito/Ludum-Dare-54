extends Node


enum Phase {
	MORNING,
	NOON,
	EVENING,
	NIGHT
}

var current_phase: Phase

var beds: Array[Bed]

var food: int = 100:
	set(value):
		food = value
		Events.food_changed.emit(value)
var water: int = 100:
	set(value):
		water = value
		Events.water_changed.emit(value)
var wood: int = 0:
	set(value):
		wood = value
		Events.wood_changed.emit(value)
var ammo: int = 0:
	set(value):
		ammo = value
		Events.ammo_changed.emit(value)
