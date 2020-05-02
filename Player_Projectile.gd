extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2(0, 0)
var speed = 10
var enableColliderTimer = 3
var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var collidedWith = move_and_collide(velocity)
	if collidedWith:
		if collidedWith.collider.has_method("do_damage"):
			collidedWith.collider.damage(damage)
	enableColliderTimer -=1
	if enableColliderTimer == 0:
		$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
