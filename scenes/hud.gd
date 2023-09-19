extends CanvasLayer

signal start_game_sgn

func update_score(value):
	$MarginContainer/Score.text = str(value)
	
func update_timer(value):
	$MarginContainer/Timer.text = str(value);
	
func show_message(text: String):
	$Message.text = text
	$Message.show()
	$Timer.start()
	
func show_game_over():
	show_message("Game Over!")
	await $Timer.timeout
	$StartButton.show()
	$Message.text = "Coin Dash!"
	$Message.show()

func _on_button_pressed():
	$Message.hide()
	$StartButton.hide()
	start_game_sgn.emit()


func _on_timer_timeout():
	$Message.hide()
