extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5;
const SpellCooldown = 15
var currentSpellCooldown = 0
var casting = false
var velocity = Vector2()
var dieTimer = -1
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
	casting = false
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('fire'):
		if(currentSpellCooldown <= 0):
			casting = true
			
	velocity = velocity.normalized() * speed
func processTimers():
	currentSpellCooldown-=1;
	if(dieTimer > 0):
		dieTimer -=1
	processDieTimer()
func _physics_process(delta):
	get_input()
	processTimers()
	processAnimation()
	processCasting()
	move_and_collide(velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func processCasting():
	if casting:
		castBasicShot()
func Die():
	dieTimer = 10
func processDieTimer():
	if dieTimer == 0:
		get_parent().remove_child(self)
func castBasicShot():
	currentSpellCooldown = SpellCooldown
	var projectile = load("res://Player_Projectile.tscn")
	
	var currentSpell = projectile.instance()
	add_child(currentSpell)
	if velocity.x != 0 or velocity.y != 0:
		var holder = velocity.normalized()
		currentSpell.velocity = Vector2(holder.x, holder.y)
	else:
		var holder = Vector2($AnimatedSprite.scale.x, 0)
		currentSpell.velocity = Vector2(holder.x, holder.y)
	currentSpell.velocity *= currentSpell.speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
