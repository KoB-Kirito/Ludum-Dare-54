class_name ChangeResourceEffect
extends Effect

enum ResourceType {FOOD, WATER, WOOD}

@export var resource: ResourceType
## Negative to reduce
@export var amount: int


func process() -> void:
	match resource:
		ResourceType.FOOD:
			Globals.food += amount
		
		ResourceType.WATER:
			Globals.water += amount
		
		ResourceType.WOOD:
			Globals.wood += amount
