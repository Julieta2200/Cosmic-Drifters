extends Control

func _on_play_button_pressed():
	LoadManager.load_scene("res://project/level_1/level_1.tscn")

func splash_screen_ends():
	$AnimationPlayer.play("load")

func planets_stars_animation_start():
	$stars_and_planets.play("planets_stars")
	
