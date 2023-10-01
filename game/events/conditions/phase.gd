class_name PhaseCondition
extends Condition


## Name of character that has to be present
@export var phase: Globals.Phase


func is_met() -> bool:
	return phase == Globals.current_phase
