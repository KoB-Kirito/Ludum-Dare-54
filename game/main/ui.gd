extends Control


func _ready() -> void:
	Events.show_text.connect(show_text)
	
	Events.food_changed.connect(on_food_changed)
	Events.water_changed.connect(on_water_changed)
	Events.wood_changed.connect(on_wood_changed)


func show_text(text: String, color: Color = Color.WHITE) -> void:
	%snd_message.play()
	%Textbox.push_color(color)
	%Textbox.append_text("\n" + text)
	%Textbox.pop()
	%Notebook.scroll_in()

func on_food_changed(value: int) -> void:
	%FoodLabel.text = "Food: " + str(value)

func on_water_changed(value: int) -> void:
	%MoraleLabel.text = "Morale: " + str(value)

func on_wood_changed(value: int) -> void:
	%WoodLabel.text = "Wood: " + str(value)
