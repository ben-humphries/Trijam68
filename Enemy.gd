extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var attacking = false
onready var target = get_node("/World/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("space"):
		attacking = true

	
	if attacking:
		$AnimatedSprite.play("attack")
		$AnimatedSprite.offset = Vector2(-24, -24)
		
		if $AnimatedSprite.frame == 8:
			attacking = false
	else:
		$AnimatedSprite.play("idle")
		$AnimatedSprite.offset = Vector2(0, 0)
#	pass
