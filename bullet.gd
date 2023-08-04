extends Area2D

var velocity 
@onready var player = get_node("/root/main/player")
var is_player_bullet

func _ready():
	$sound.play()
	position += Vector2.RIGHT.rotated(rotation) * 150

func init(parent, vel, is_player_bullet):
		position = parent.position
		rotation = parent.rotation
		velocity = vel
		self.is_player_bullet = is_player_bullet
		if(is_player_bullet):
			add_to_group("player_bullets")
		parent.get_node("/root/main/bullets").add_child(self)
		

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()

func _on_bullet_area_entered(area):
	queue_free()
