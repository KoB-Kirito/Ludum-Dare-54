class_name PhaseCondition
extends Condition


## OR - If any
@export var phases: Array[Globals.Phase]


func is_met() -> bool:
	for phase in phases:
		if phase == Globals.current_phase:
			return true
	return false
