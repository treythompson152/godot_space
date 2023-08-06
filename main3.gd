extends Node2D

signal loading_screen
	
func _on_player_dead():
	loading_screen.emit()
	$TitleScreen.show_message("Game Over")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
	# stop spawning ememies


func _on_title_screen_start_game():
	# start spawning the enemies
	# start music / sound effects
	pass

func _on_player_win():
	loading_screen.emit()
	$TitleScreen.show_message("Congrats! You Win All Levels!")
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
