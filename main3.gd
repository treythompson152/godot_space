extends Node2D

signal loading_screen


# Play the Theme Music once the game starts
func _ready():
	$ThemeMusic.play()


# Show Game Over and reload to the beginning
func _on_player_dead():
	loading_screen.emit()
	$TitleScreen.show_message("Game Over")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")


# On the button click, stop the theme music and start the game music
func _on_title_screen_start_game():
	$ThemeMusic.stop()
	$GameMusic.play()


# Handles a player win with a sound and changing levels
func _on_player_win():
	loading_screen.emit()
	$TitleScreen.show_message("Congrats! You Win All Levels!")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
