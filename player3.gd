extends Area2D

signal dead
signal win
signal level_complete
signal hide_enemies

@export var velocity = 2000
@export var turning = 4.0
@export var health = 10

var Bullet = preload("res://player_bullet.tscn")
var Explosion = preload("res://explosion.tscn")
@export var score = 0

func _process(delta):
	if Input.is_action_pressed("turn_left"):
		rotation -= turning * delta
	if Input.is_action_pressed("turn_right"):
		rotation += turning * delta
	if Input.is_action_just_pressed("fire"):
		Bullet.instantiate().init(self, 4000, true)

	gamepad(delta)
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if score >= 20:
		hide_enemies.emit()
		level_complete.emit()
		velocity = 0
		await get_tree().create_timer(3.0).timeout
		win.emit()
	
func gamepad(delta):
	pass

func _on_player_area_entered(area):
	health -= 1
	get_node("../HUD/health").value = health
	if health <= 0:
		hide_enemies.emit()
		var explosion_instance = Explosion.instantiate()
		get_parent().add_child(explosion_instance)
		explosion_instance.position = position
		explosion_instance.get_node("AnimatedSprite2D").play()
		$AnimationPlayer.play("fade")
		velocity = 0
		dead.emit()
	$crash_sound.play()
	await get_tree().create_timer(1.0).timeout
	
