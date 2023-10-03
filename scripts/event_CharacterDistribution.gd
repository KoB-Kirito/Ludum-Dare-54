extends Node

@export var count : int = 1
enum distributionFlag{random,bed,charactername,eventcharacters}
#random -> effects [count] random characters (in the shelter)
#bed -> effects [count] selected beds
#charactername -> effects [count] characters defined by their name as string
#eventcharacters -> effects [count] characters in 'characterInEvent' defined by int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

