extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var timer = 750
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer-=1
	if timer < 0:
		get_parent().remove_child(self)
	if abs(frame - 11) < 3:
		get_node("KinematicBody2D/CollisionShape2D").disabled  = false
	else:
				get_node("KinematicBody2D/CollisionShape2D").disabled  = true
#	pass
