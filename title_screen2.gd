extends CanvasLayer

signal start_game
	
func show_game_over():
	$StartButton.show()
	$Title.show()
	$Subtitle.show()


func _on_start_button_pressed():
	$StartButton.hide()
	$Title.hide()
	$Subtitle.hide()
	start_game.emit()
	
