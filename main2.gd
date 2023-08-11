extends Node2D

signal loading_screen
	
func _ready():
	$ThemeMusic.play()
	

func _on_player_dead():
	loading_screen.emit()
	$TitleScreen.show_message("Game Over")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")


func _on_title_screen_start_game():
	$ThemeMusic.stop()
	$GameMusic.play()
	pass

func _on_player_win():
	loading_screen.emit()
	$LevelUp.play()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://main3.tscn")
