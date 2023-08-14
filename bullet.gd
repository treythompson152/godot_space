extends Area2D

var velocity 
@onready var player = get_node("/root/main/player")
var is_player_bullet

# PLay the "Pew" Sounds on Creation and rotated in the correct direction
func _ready():
	$sound.play()
	position += Vector2.RIGHT.rotated(rotation) * 150


# Creates the bullet from the senter of the player
func init(parent, vel, is_player_bullet):
		position = parent.position
		rotation = parent.rotation
		velocity = vel
		self.is_player_bullet = is_player_bullet
		# Keeps track of which bullets are the players
		if(is_player_bullet):
			add_to_group("player_bullets")
		parent.get_node("/root/main/bullets").add_child(self)


# Will free the bullet if gets out of the players range
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if position.distance_to(player.position) > 5000:
		queue_free()


# Handles to hide the bullet once it hits something
func _on_bullet_area_entered(area):
	queue_free()
