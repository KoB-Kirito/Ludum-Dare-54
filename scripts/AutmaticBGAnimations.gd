extends AnimatedSprite2D

@onready var _animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".play("Full")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if Input.is_action_pressed("ui_right"):
##
	#var animationTimer = 0
	#animationTimer = animationTimer+1
	#if(animationTimer == 1):
		#$".".play("flyAway")
#
	#if(animationTimer == 16):
		#$".".stop("flyAway")
	#if(animationTimer> 800): 
		#$".".play("comeBack")
	##else:
		#_animated_sprite.stop()
	pass


