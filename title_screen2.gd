extends CanvasLayer

signal start_game


# Is called to change the text
func show_message(text):
	$Subtitle.text = text
	$Subtitle.show()
	$MessageTimer.start()


# Handles when the start button is clicked
func _on_start_button_pressed():
	$Click.play()
	$StartButton.hide()
	$Subtitle.hide()
	show_message("Level 2 - Goal: 10 points")
	$Ready.play()
	await $MessageTimer.timeout
	start_game.emit()


# Hides the words in between levels
func _on_message_timer_timeout():
	$Subtitle.hide()


# Displays the level complete screen
func _on_player_level_complete():
	show_message("Level 2 Complete!")
	await $MessageTimer.timeout

