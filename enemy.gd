extends Area2D

@export var VELOCITY = 1000.0
@export var TURNING = 0.7
@export var FIRE_RATE = 0.01

var Bullet = preload("res://enemy_bullet.tscn")
@onready var player = get_node("/root/main/player")

func _process(delta):
	var d = player.position.angle_to_point(position) 
	rotation = rotate_toward(rotation, d, TURNING*delta)
	position += Vector2.RIGHT.rotated(rotation) * VELOCITY * delta

	if position.distance_to(player.position) > 7000:
		queue_free()

	if randf()<FIRE_RATE:
		Bullet.instantiate().init(self, 3000)

# Custom implementation of the rotate_toward function
func rotate_toward(current_angle, target_angle, max_rotation):
	var diff = current_angle - target_angle
	if diff > PI:
		diff -= PI * 2
	elif diff < -PI:
		diff += PI * 2

	var clamped_diff = clamp(diff, -max_rotation, max_rotation)
	return current_angle + clamped_diff


func _on_enemy_area_entered(area):
	$explosion.play()
	$AnimationPlayer.play("fade")
	$CollisionPolygon2D.queue_free()
	$CPUParticles2D.emitting = true
	$CPUParticles2D.show()
	player.score += 1
	get_node("/root/main/HUD/score").text = str(player.score)
	await get_tree().create_timer(1.0).timeout
	queue_free()
