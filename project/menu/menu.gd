extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://project/level_1/level_1.tscn")




func _on_back_button_pressed():
	$Background.set_modulate("ffffff")
	$Settings.visible = false
	$VBoxContainer.visible = true


func _on_settings_button_pressed():
	$Background.set_modulate("ffffff5b")
	$Settings.visible =  true
	$VBoxContainer.visible = false
