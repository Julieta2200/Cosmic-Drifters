extends Control

func _on_play_button_pressed():
	LoadManager.load_scene("res://project/level_1/level_1.tscn")

func splash_screen_ends():
	$AnimationPlayer.play("load")
