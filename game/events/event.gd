class_name Event
extends Resource

@export var name: String

@export_group("Settings")

## All conditions have to be met for this event to get selected
@export var conditions: Array[Condition]

## Title of the dialog box
#@export var title: String
## Text of the dialog box
@export_multiline var text: String

## Image to display
@export var image: Texture2D

@export var choices: Array[Choice]
