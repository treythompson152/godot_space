extends Timer

var Base = preload("res://base.tscn")
@export var MAX_BASES = 3
@onready var player = get_node("/root/main/player")

var is_spawner_active = false

func _on_enemy_spawner_timeout():
	if is_spawner_active && get_child_count() < MAX_BASES:
		var base = Base.instantiate()
		add_child(base)
		

func _on_title_screen_start_game():
	is_spawner_active = true
	
func hide_all_bases():
	for base in get_children():
		base.queue_free()


func _on_player_hide_bases():
	hide_all_bases() # Replace with function body.
