class_name ChangeResourceEffect
extends Effect

enum ResourceType {FOOD, WATER, WOOD, MEDICINE, AMMO}

@export var resource: ResourceType
## Negative to reduce
@export var amount: int


func process() -> void:
	match resource:
		ResourceType.FOOD:
			Globals.food += amount
			if Globals.food < 0:
				Globals.food = 0
		
		ResourceType.WATER:
			Globals.water += amount
			if Globals.water < 0:
				Globals.water = 0
		
		ResourceType.WOOD:
			Globals.wood += amount
			if Globals.wood < 0:
				Globals.wood = 0
		
		ResourceType.MEDICINE:
			Globals.medicine += amount
			if Globals.medicine < 0:
				Globals.medicine = 0
		
		ResourceType.AMMO:
			Globals.ammo += amount
			if Globals.ammo < 0:
				Globals.ammo = 0
