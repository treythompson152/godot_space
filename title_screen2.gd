extends CanvasLayer

signal start_game

func show_message(text):
	$Subtitle.text = text
	$Subtitle.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	$StartButton.show()
	$Title.show()
	$Subtitle.show()


func _on_start_button_pressed():
	$StartButton.hide()
	$Subtitle.hide()
	show_message("Level 2 - Goal: 10 points")
	await $MessageTimer.timeout
	start_game.emit()
	

func _on_message_timer_timeout():
	$Subtitle.hide()

func _on_player_level_complete():
	show_message("Level Complete!")
	await $MessageTimer.timeout
