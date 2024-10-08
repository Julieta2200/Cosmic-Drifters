extends Control 

var butten_state : bool
var recording : Dictionary

var stop_button = ["res://assets/recording/Recording Panel/Stop_button/Stop1.png", 
					"res://assets/recording/Recording Panel/Stop_button/Stop2.png"]

var play_button = ["res://assets/recording/Recording Panel/Play_button/Play1.png",
					"res://assets/recording/Recording Panel/Play_button/Play2.png"]

@onready var recording_panel = $"../../../.."
@onready var button = $play_button
@onready var recording_animation = $recording_animation

func _on_play_button_pressed():
	if button.texture_normal == load(play_button[0]):
		recording_panel.display_recording(self)
		recording_panel.stoping()
		recording_animation.play("recording")
		change_texture(stop_button)
		butten_state = true
	else:
		recording_panel.display_recording_stop()
		recording_animation.stop()
		change_texture(play_button)
		butten_state = false
		
func change_texture(button_texture):
	button.texture_normal = load(button_texture[0])
	button.texture_pressed = load(button_texture[1])

func change(number, group_name):
	$number.text = str(number + 1) + "."
	$name.text = str(group_name)

func _on_delete_button_pressed():
	recording_panel.delete_recording(self)
