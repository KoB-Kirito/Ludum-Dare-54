extends TextureRect


@export var out_position: Vector2
@export var in_position: Vector2
@onready var auto_hide_timer: Timer = $AutoHideTimer


func _ready() -> void:
	position = out_position


func scroll_in() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", in_position, 0.4)
	auto_hide_timer.stop()

func scroll_out() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", out_position, 0.5)


func autohide() -> void:
	pass
	#auto_hide_timer.start()


var mouse_is_entered: bool = false
var turn_point := Vector2(400, 509)
func _physics_process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	#print(mouse_pos)
	if not mouse_is_entered and mouse_pos.x < turn_point.x and mouse_pos.y < turn_point.y:
		mouse_is_entered = true
		scroll_in()
	elif mouse_is_entered and (mouse_pos.x > turn_point.x or mouse_pos.y > turn_point.y):
		mouse_is_entered = false
		scroll_out()


func _on_auto_hide_timer_timeout() -> void:
	scroll_out()
