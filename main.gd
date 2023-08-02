extends Node2D

	
func _on_player_dead():
	$TitleScreen.show_game_over()
	# stop spawning ememies


func _on_title_screen_start_game():
	# start spawning the enemies
	# start music / sound effects
	pass
	
