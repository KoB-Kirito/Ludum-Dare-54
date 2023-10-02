extends Node


signal character_selected(character: Character, bed: Bed)

signal food_collected(amount: int)
signal water_collected(amount: int)
signal wood_collected(amount: int)
signal medicine_collected(amount: int)
signal ammo_collected(amount: int)

signal food_changed(value: int)
signal water_changed(value: int)
signal wood_changed(value: int)
signal medicine_changed(value: int)
signal ammo_changed(value: int)

signal show_text(text: String, color: Color)
signal advance_phase
