extends Control

func _on_play_button_pressed():
	LoadManager.load_scene("res://project/initial_scene.tscn")

func splash_screen_ends():
	$AnimationPlayer.play("load")

func planets_stars_animation_start():
	$stars_and_planets.play("planets_stars")
	
func menu_music_start():
	AudioPlayer.menu_music()
	
func _on_settings_button_pressed():
	$settings.visible = true

