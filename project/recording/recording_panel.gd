extends Control

func stoping():
	for i in $panel/ScrollContainer/VBoxContainer.get_children():
		if i.butten_state:
			i.change_texture(i.play_button)
			i.recording_animation.stop()
