extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var SPEED = 20
export var DIST_THRESHOLD = 50
var attacking = false
onready var target = get_node("/root/World/Player")

var velocity : Vector2 = Vector2()

var health = 100

func die():
	get_parent().remove_child(self)

func do_damage(damage):
	health -= damage
	if health < 0:
		die()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	velocity = Vector2(0,0)
	if target:
		var target_dir = (target as KinematicBody2D).position - position
		target_dir = target_dir.normalized()
		velocity = target_dir * SPEED
		
		var target_dist = position.distance_to((target as KinematicBody2D).position)
		if target_dist < DIST_THRESHOLD:
			if target.has_method("die"):
				target.die()
			attacking = true
		else:
			attacking = false
	
	if velocity.x < 0:
			$AnimatedSprite.flip_h = false
	else:
			$AnimatedSprite.flip_h = true
	
	if attacking:
		velocity = Vector2(0,0)
		$AnimatedSprite.play("attack")
		if $AnimatedSprite.flip_h:
			$AnimatedSprite.offset = Vector2(24, -24)
		else:
			$AnimatedSprite.offset = Vector2(-24, -24)
		
		if $AnimatedSprite.frame == 8:
			attacking = false
	else:
		$AnimatedSprite.play("idle")
		$AnimatedSprite.offset = Vector2(0, 0)
#	pass
	position += velocity * delta
