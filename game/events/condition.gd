class_name Condition
extends Resource
# parent

## Text is shown on choices if condition is not met. Choice will not appear at all if this is empty.
@export var fail_text: String

func is_met() -> bool:
	return true
