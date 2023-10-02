class_name TextlogEffect
extends Effect

@export_multiline var text: String
@export_color_no_alpha var color: Color = Color.BLACK


func process() -> void:
	Events.show_text.emit(text, color)
