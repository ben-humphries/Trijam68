extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5;
func processAnimation():
	if(velocity.x > 0):
		$AnimatedSprite.scale.x =1
	if(velocity.x < 0):
		$AnimatedSprite.scale.x = -1;
	if abs(velocity.x) > 0 or abs(velocity.y) > 0:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
func get_input():
	velocity = Vector2()
	#print("awefawef")
	if Input.is_action_pressed('right'):
		#print("right")
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	#print(velocity)
	processAnimation()
	move_and_collide(velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var velocity = Vector2()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
