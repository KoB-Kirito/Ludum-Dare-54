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


func _on_mouse_entered() -> void:
	scroll_in()

func _on_mouse_exited() -> void:
	scroll_out()


func _on_auto_hide_timer_timeout() -> void:
	scroll_out()
