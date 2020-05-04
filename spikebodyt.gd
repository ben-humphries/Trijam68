extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
const damage = 150
func _physics_process(delta):
	var collidedWith = move_and_collide(Vector2(0, 0))
	if collidedWith:
		if collidedWith.collider.has_method("do_damage"):
			collidedWith.collider.do_damage(damage)
