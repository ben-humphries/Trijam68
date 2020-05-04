extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 3;
const SpellCooldown = 45
var currentSpellCooldown = 0
var casting = false
var velocity = Vector2()
var dieTimer = -1
var lastPlayerDirection = Vector2()
var projectile = load("res://Player_Projectile.tscn")
var shadowToClone = load("res://Shadow.tscn")
var spikesToClone = load("res://Spikes.tscn")
var castSpellTriggered = false
var score = 0
var currentShadow = null
func processAnimation():
	
	if(velocity.x > 0):
		$AnimatedSprite.scale.x =1
	if(velocity.x < 0):
		$AnimatedSprite.scale.x = -1;
	if casting:
		$AnimatedSprite.play("Cast_Spell")
	else:
		if abs(velocity.x) > 0 or abs(velocity.y) > 0:
			$AnimatedSprite.play("Walk")
		else:
			$AnimatedSprite.play("Idle")
	processCastingFrames()
func get_input():
	velocity = Vector2()
	castSpellTriggered = false
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if(Input.is_action_pressed('reload_when_dead') and dieTimer==0):
		get_tree().reload_current_scene()
	if velocityNotZero():
		lastPlayerDirection = Vector2(velocity.x, velocity.y)
	velocity = velocity.normalized() * speed
	
func velocityNotZero() -> bool:
	return velocity.x != 0 || velocity.y != 0
func processTimers():
	if(dieTimer > 0):
		dieTimer -=1
	processDieTimer()
func processCastingFrames():
	if casting and $AnimatedSprite.frame == 4:
		casting = false
func _physics_process(delta):
	get_input()
	processTimers()
	processAnimation()
	if(dieTimer < 0):
		processCasting()
		move_and_collide(velocity)
	if dieTimer == 0:
		get_node("/root/World/Player/Camera2D/GUI/RestartLabel").visible = true
	get_node("/root/World/Player/Camera2D/GUI/ScoreLabel").text = "Score: " + str(score)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func processCasting():
	castSpellTriggered = false
	currentSpellCooldown-=1
	print(currentSpellCooldown)
	if Input.is_action_pressed('cast_basic_shot') or Input.is_action_pressed("cast_fireball") or Input.is_action_pressed("cast_jump") or Input.is_action_pressed("cast_shadow") or Input.is_action_pressed("cast_spikes"):
		if(currentSpellCooldown <= 0):
			castSpellTriggered = true
			currentSpellCooldown = SpellCooldown
			
	if castSpellTriggered:
		casting = true
		if Input.is_action_pressed('cast_basic_shot'):
			castBasicShot()
		if Input.is_action_pressed('cast_fireball'):
			castFireball()
		if Input.is_action_pressed('cast_jump'):
			print("jumping")
			castJump()
		if Input.is_action_pressed('cast_shadow'):
			print("casting shadow")
			castShadow()
		if Input.is_action_pressed('cast_spikes'):
			castSpikes()
func die():
	dieTimer = 100
	
func processDieTimer():
	if dieTimer == 0:
		$AnimatedSprite.hide()
func castBasicShot():
	
	var currentSpell = projectile.instance()
	add_child(currentSpell)
	if velocity.x != 0 or velocity.y != 0:
		var holder = velocity.normalized()
		currentSpell.velocity = Vector2(holder.x, holder.y)
	elif lastPlayerDirection.x != 0 or lastPlayerDirection.y != 0:
		var holder = Vector2(lastPlayerDirection.x, lastPlayerDirection.y)
		currentSpell.velocity = Vector2(holder.x, holder.y)
	else:
		var holder = Vector2(1, 0)
		currentSpell.velocity = Vector2(holder.x, holder.y)
	currentSpell.velocity *= currentSpell.speed
func castFireball():
	pass
func castJump():
	var jumpBy =velocity.normalized() * 75
	move_and_collide(jumpBy)
func castShadow():
	if currentShadow == null:
		currentShadow = shadowToClone.instance()
		get_parent().add_child(currentShadow)
		currentShadow.position = Vector2(position.x, position.y)
	else:
		position = Vector2(currentShadow.position.x, currentShadow.position.y)
		currentShadow.get_parent().remove_child(currentShadow)
		currentShadow = null
func castSpikes():
	var spikes = spikesToClone.instance()
	spikes.position = Vector2(position.x, position.y)
	get_parent().add_child(spikes)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
