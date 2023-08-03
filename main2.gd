extends Node2D

	
func _on_player_dead():
	$TitleScreen.show_game_over()
	# stop spawning ememies


func _on_title_screen_start_game():
	# start spawning the enemies
	# start music / sound effects
	pass

func _on_player_win():
	#get_tree().change_scene_to_file("res://main3.tscn")
	$TitleScreen.show_message("Congrats! You Win!")
