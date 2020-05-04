extends KinematicBody2D



var velocity = Vector2(0, 0)
var speed = 2.2
var enableColliderTimer = 15
var damage = 200
var timer = 500
var toClone = load("res://Fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	
	timer-=1
	if(timer <= 0):
		get_parent().remove_child(self)
	var collidedWith = move_and_collide(velocity)
	if collidedWith:
		if collidedWith.collider.has_method("do_damage"):
			collidedWith.collider.do_damage(damage)
			if damage >= 50 :
				var newFireballOne = toClone.instance()
				get_parent().add_child((newFireballOne))
				newFireballOne.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballOne.velocity = Vector2(1, 0).normalized() * speed
				newFireballOne.position = Vector2(position.x, position.y)
				
				
				var newFireballTwo = toClone.instance()
				get_parent().add_child((newFireballTwo))
				newFireballTwo.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballTwo.velocity = Vector2(1, -1).normalized() * speed
				newFireballTwo.position = Vector2(position.x, position.y)
				
				var newFireballThree = toClone.instance()
				get_parent().add_child((newFireballThree))
				newFireballThree.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballThree.velocity = Vector2(0, -1).normalized() * speed
				newFireballThree.position = Vector2(position.x, position.y)
				
				var newFireballFour = toClone.instance()
				get_parent().add_child((newFireballFour))
				newFireballFour.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballFour.velocity = Vector2(-1, -1).normalized() * speed
				newFireballFour.position = Vector2(position.x, position.y)
				
				var newFireballOnee = toClone.instance()
				get_parent().add_child((newFireballOnee))
				newFireballOnee.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballOnee.velocity = Vector2(-1, 0).normalized() * speed
				newFireballOnee.position = Vector2(position.x, position.y)
				
				var newFireballOneee = toClone.instance()
				get_parent().add_child((newFireballOneee))
				newFireballOneee.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballOneee.velocity = Vector2(-1, 1).normalized() * speed
				newFireballOneee.position = Vector2(position.x, position.y)
				
				var newFireballOneeee = toClone.instance()
				get_parent().add_child((newFireballOneeee))
				newFireballOneeee.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballOneeee.velocity = Vector2(0, 1).normalized() * speed
				newFireballOneeee.position = Vector2(position.x, position.y)
				
				var newFireballOeeene = toClone.instance()
				get_parent().add_child((newFireballOeeene))
				newFireballOeeene.get_node("AnimatedSprite").scale = Vector2($AnimatedSprite.scale.x/1.5, $AnimatedSprite.scale.y/1.5)
				newFireballOeeene.velocity = Vector2(1, 1).normalized() * speed
				newFireballOeeene.position = Vector2(position.x, position.y)
				
			
				
		get_parent().remove_child(self)
	enableColliderTimer -=1
	if enableColliderTimer == 0:
		$CollisionShape2D.disabled = false
