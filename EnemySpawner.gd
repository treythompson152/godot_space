extends Timer

var Enemy = preload("res://enemy.tscn")
@export var MAX_ENEMIES = 5
@export var MAX_SCORE = 500
@export var MIN_SCORE = 0
@onready var player = get_node("/root/main/player")

var is_spawner_active = false

func _on_enemy_spawner_timeout():
	if is_spawner_active && get_child_count() < MAX_ENEMIES && player.score <= MAX_SCORE && player.score >= MIN_SCORE:
		var enemy = Enemy.instantiate()
		add_child(enemy)
		

func _on_title_screen_start_game():
	is_spawner_active = true
