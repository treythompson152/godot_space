extends Node2D

	
func _on_player_dead():
	$TitleScreen.show_message("Game Over")
	await get_tree().create_timer(3.0).timeout
	# stop spawning ememies
	get_tree().reload_current_scene()


func _on_title_screen_start_game():
	# start spawning the enemies
	# start music / sound effects
	pass
	

func _on_player_win():
	get_tree().change_scene_to_file("res://main2.tscn")

