extends TileMap

onready var target = get_node("/root/World/Player")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_pos = (target as KinematicBody2D).position
	player_pos /= 16
	
	for x in range(player_pos.x - 16, player_pos.x + 16):
		for y in range(player_pos.y - 16, player_pos.y + 16):
			if get_cellv(Vector2(x,y)) == -1:
				var random1 = rng.randi_range(0, 1)
				var random2 = rng.randi_range(0, 1)
				var random3 = rng.randi_range(0, 1)
				set_cellv(Vector2(x,y), random1, random2, random3)
#	pass
