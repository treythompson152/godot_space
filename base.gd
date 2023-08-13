extends Area2D

@onready var player = get_node("/root/main/player")

func _ready():
	position = player.position + Vector2.RIGHT.rotated(randf_range(0, PI*2)) * 5000
	rotation = player.position.angle_to_point(position) 

func _process(delta):
	add_to_group("bases")
	if position.distance_to(player.position) > 7000:
		queue_free()
