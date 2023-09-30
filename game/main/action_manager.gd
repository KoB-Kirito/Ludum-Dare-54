extends Node


func _ready() -> void:
	Events.food_collected.connect(on_food_collected)
	Events.water_collected.connect(on_water_collected)
	Events.wood_collected.connect(on_wood_collected)


func on_food_collected(amount: int) -> void:
	Globals.food += amount
	%FoodLabel.text = "Food: " + str(Globals.food)
	%Textbox.add_text("\n" + str(amount) + " food collected")


func on_water_collected(amount: int) -> void:
	Globals.water += amount
	%WaterLabel.text = "Water: " + str(Globals.water)
	%Textbox.add_text("\n" + str(amount) + " water collected")


func on_wood_collected(amount: int) -> void:
	Globals.wood += amount
	%WoodLabel.text = "Wood: " + str(Globals.wood)
	%Textbox.add_text("\n" + str(amount) + " wood collected")
