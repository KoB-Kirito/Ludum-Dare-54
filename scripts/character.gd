class_name Character
extends Resource


@export var name: String

@export var portrait: Texture2D
@export var image: Texture2D


#Statuspoints
@export var healthpoints: int = 12
@export var sleep: int = 5
@export var hunger: int = 5
@export var morale: int = 5
@export var happyness: int = 5


@export var Location: String = "Shelter"

#Stats
@export var Offense: int = 5
@export var Defense: int = 5
@export var Loyalty: int = 5
@export var Leadership: int = 5
@export var Gather: int = 5
@export var Trading: int = 5
@export var Cooking: int = 5
@export var Crafting: int = 5
@export var Science: int = 5
@export var Medicine: int = 5



# etc..

@export var actions: Array[RestAction]
