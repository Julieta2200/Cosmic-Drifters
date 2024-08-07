extends Control

var butten_state : bool

var stop_button = ["res://assets/recording/Recording Panel/Stop_button/Stop1.png", 
					"res://assets/recording/Recording Panel/Stop_button/Stop2.png"]

var play_button = ["res://assets/recording/Recording Panel/Play_button/Play1.png",
					"res://assets/recording/Recording Panel/Play_button/Play2.png"]

@onready var button = $play_button
@onready var recording_animation = $recording_animation


func _on_play_button_pressed():
	$"../..".stoping()
	if button.texture_normal == load(play_button[0]):
		recording_animation.play("recording")
		change_texture(stop_button)
		butten_state = true
	else:
		recording_animation.stop()
		change_texture(play_button)
		butten_state = false
		
	
func change_texture(button_texture):
	button.texture_normal = load(button_texture[0])
	button.texture_pressed = load(button_texture[1])

