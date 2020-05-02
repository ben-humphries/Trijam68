extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var SPAWN_RATE = 0.5 #spawns per second
onready var player = get_node("/root/World/Player")
var enemy = load("res://Enemy.tscn")

var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timer += delta
	
	if timer > 1 / SPAWN_RATE:
		var new_enemy = enemy.instance()
		var random = randi() % 4 + 1
		if random == 1:
			new_enemy.position = (player as KinematicBody2D).position + Vector2(0,200)
		elif random == 2:
			new_enemy.position = (player as KinematicBody2D).position + Vector2(300,0)
		elif random == 3:
			new_enemy.position = (player as KinematicBody2D).position + Vector2(0,-200)
		elif random == 4:
			new_enemy.position = (player as KinematicBody2D).position + Vector2(-300,0)
		add_child(new_enemy)
		timer = 0
#	pass
