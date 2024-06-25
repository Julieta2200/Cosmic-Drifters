extends Control

func _on_switch_music_toggled(button_pressed):
	if button_pressed:
		AudioPlayer.play()
		AudioPlayer.state = true
	else:
		AudioPlayer.stop()
		AudioPlayer.state = false

func _on_back_pressed():
	visible = false
