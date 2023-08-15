extends Timer

# Type of enemies
var Enemy = preload("res://enemy3.tscn")

@export var MAX_ENEMIES = 10
@onready var player = get_node("/root/main/player")

var is_spawner_active = false


# Spawns the enemies
func _on_enemy_spawner_timeout():
	if is_spawner_active && get_child_count() < MAX_ENEMIES:
		var enemy = Enemy.instantiate()
		add_child(enemy)


# Starts the spawning the enemies on start
func _on_title_screen_start_game():
	is_spawner_active = true


# Frees all of the enemies on a loss or a win
func hide_all_enemies():
	for enemy in get_children():
		enemy.queue_free()


# Helper function to signal to the function above from the splayer script
func _on_player_hide_enemies():
	hide_all_enemies()
