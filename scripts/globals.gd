extends Node


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
