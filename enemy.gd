extends Area2D


@export var VELOCITY = 1000.0
@export var TURNING = 2.0
@export var FIRE_RATE = 0.01

var destroyed = false
var Bullet = preload("res://enemy_bullet.tscn")
var Explosion = preload("res://explosion.tscn")
@onready var player = get_node("/root/main/player")
 

# Starts the enemy pointed at the player
func _ready():
	position = player.position + Vector2.RIGHT.rotated(randf_range(0, PI*2)) * 5000
	rotation = player.position.angle_to_point(position) 


# Constantly trackets the player and fires when in range
func _process(delta):
	var d = player.position.angle_to_point(position) 
	rotation = Util.rotate_toward(rotation, d, TURNING*delta)
	position += Vector2.RIGHT.rotated(rotation) * VELOCITY * delta
	
	if position.distance_to(player.position) > 7000:
		queue_free()
	
	if randf()<FIRE_RATE:
		if position.distance_to(player.position) < 3000:
			Bullet.instantiate().init(self, 3000, false)


# Handles the destruction of enemies
func _on_enemy_area_entered(area):
	if !destroyed:
		# The enemy only is destroyed when it is hit with a bullet, not when the player runs into the enemy
		var player_bullets = get_tree().get_nodes_in_group("player_bullets")
		if area in player_bullets:
			destroyed = true
			add_to_group("destroyed_enemies")
			$explosion.play()
			var explosion_instance = Explosion.instantiate() 
			get_parent().add_child(explosion_instance)
			explosion_instance.position = position
			explosion_instance.get_node("AnimatedSprite2D").play()
			$AnimationPlayer.play("fade")
			player.score += 1
			get_node("/root/main/HUD/score").text = str(player.score)
			await get_tree().create_timer(0.5).timeout
			queue_free()


	
