extends Area2D

signal base_collision

@export var VELOCITY = 1000.0
@export var TURNING = 2.0
@export var FIRE_RATE = 0.01

var Explosion = preload("res://explosion.tscn")
@onready var player = get_node("/root/main/player")

func _ready():
	position = player.position + Vector2.RIGHT.rotated(randf_range(0, PI*2)) * 5000
	rotation = player.position.angle_to_point(position) 

func _process(delta):
	add_to_group("bases")
	var d = player.position.angle_to_point(position) 
	rotation = Util.rotate_toward(rotation, d, TURNING*delta)
	position += Vector2.RIGHT.rotated(rotation) * VELOCITY * delta
	
	if position.distance_to(player.position) > 7000:
		queue_free()
		
func _on_area_entered(area):
	base_collision.emit() # Replace with function body.
