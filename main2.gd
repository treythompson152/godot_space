extends Node2D

	
func _on_player_dead():
	$TitleScreen.show_message("Game Over")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
	# stop spawning ememies


func _on_title_screen_start_game():
	# start spawning the enemies
	# start music / sound effects
	pass

func _on_player_win():
	get_tree().change_scene_to_file("res://main3.tscn")
