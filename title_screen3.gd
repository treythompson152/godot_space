extends CanvasLayer

signal start_game

func show_message(text):
	$Subtitle.text = text
	$Subtitle.show()
	$MessageTimer.start()
	

func _on_start_button_pressed():
	$Click.play()
	$StartButton.hide()
	$Subtitle.hide()
	show_message("Level 3 - Goal: 20 points")
	$Ready.play()
	await $MessageTimer.timeout
	start_game.emit()
	

func _on_message_timer_timeout():
	$Subtitle.hide()

func _on_player_level_complete():
	show_message("Level 3 Complete!")
	await $MessageTimer.timeout
