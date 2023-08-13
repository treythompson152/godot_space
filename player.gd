extends Area2D

signal dead
signal win
signal level_complete
signal hide_enemies
signal shield_activation

var hide_enemies_flag = false
var loading_screen = false
var one_time_flag = true
@export var velocity = 2000
@export var turning = 4.0
@export var health = 10
@export var score = 0

var Bullet = preload("res://player_bullet.tscn")
var Explosion = preload("res://explosion.tscn")
var SmallExplosion = preload("res://small_explosion.tscn")



func _process(delta):
	if Input.is_action_pressed("turn_left"):
		rotation -= turning * delta
	if Input.is_action_pressed("turn_right"):
		rotation += turning * delta
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = Bullet.instantiate().init(self, 4000, true)
		$pew.play()
	if Input.is_action_just_pressed("dash"):
		velocity = 3000
	if Input.is_action_just_released("dash"):
		velocity = 2000
 
	gamepad(delta)
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	if (score >= 5 and one_time_flag):
		one_time_flag = false
		await get_tree().create_timer(1.0).timeout
		hide_enemies.emit()
		hide_enemies_flag = true
		level_complete.emit()
		velocity = 0
		$Congrats.play()
		await get_tree().create_timer(2.0).timeout
		$MissionCompleted.play()
		await get_tree().create_timer(1.5).timeout
		win.emit()
		
	if hide_enemies_flag:
		hide_enemies.emit()
		
		
func gamepad(delta):
	pass

func _on_player_area_entered(area):
	if(!loading_screen):
		var destroyed_enemies = get_tree().get_nodes_in_group("destroyed_enemies")
		var bases = get_tree().get_nodes_in_group("bases")
		if !(area in bases):
			shield_activation.emit()
		if !(area in destroyed_enemies or area in bases):
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
				$explosion.play()
				await get_tree().create_timer(1.0).timeout
				$GameOver.play()
				dead.emit()
			$crash_sound.play()
			flicker()
			await get_tree().create_timer(1.0).timeout


func _on_main_loading_screen():
	loading_screen = true
	
func flicker():
	for i in range(4):
		hide()
		await get_tree().create_timer(0.05).timeout
		show()
		await get_tree().create_timer(0.05).timeout
	


