class_name TakeDamageEffect
extends Effect


## How much damage
@export var amount: int

## Name of character, leave empty for all
@export var character: String

## Number of bed affected, 0 for all
@export_range(0, 5, 1) var bed: int = 0


func process() -> void:
	if character != null and not character.is_empty():
		for b: Bed in Globals.beds:
			if b.character.name.to_lower() == character.to_lower():
				b.character.healthpoints -= amount
				return
		return
		
	elif bed > 0:
		var char := Globals.beds[bed - 1].character
		if char == null:
			return
		char.healthpoints -= amount
		return
		
	else:
		for b: Bed in Globals.beds:
			if b.character != null:
				b.character.healthpoints -= amount
