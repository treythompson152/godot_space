extends Area2D

signal dead

@export var velocity = 0
@export var turning = 4.0
@export var health = 10

var Bullet = preload("res://player_bullet.tscn")
var Explosion = preload("res://explosion.tscn")
var score = 0

func _process(delta):
	if Input.is_action_pressed("turn_left"):
		rotation -= turning * delta
	if Input.is_action_pressed("turn_right"):
		rotation += turning * delta
	if Input.is_action_just_pressed("fire"):
		Bullet.instantiate().init(self, 4000)

	gamepad(delta)
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	
func gamepad(delta):
	pass

func _on_player_area_entered(area):
	health -= 1
	get_node("../HUD/health").value = health
	if health <= 0:
		get_tree().reload_current_scene()
		dead.emit()
	$crash_sound.play()
	await get_tree().create_timer(1.0).timeout
	
