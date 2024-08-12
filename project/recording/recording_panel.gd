extends Control

var recording_scene 
var recordings : Dictionary

@onready var recording_dialog = $"../recording_dialog"
@onready var recordings_container = $panel/ScrollContainer/VBoxContainer


func stoping():
	for i in recordings_container.get_children():
		if i.butten_state:
			i.change_texture(i.play_button)
			i.recording_animation.stop()

func open(r : Dictionary):
	recordings = r
	for i in range(recordings.size()):
		recording_scene = preload("res://project/recording/recording_number.tscn").instantiate()
		recordings_container.add_child(recording_scene)
		recording_scene.change(i)
	visible = true
	
func display_recording(recording):
	var index = 0
	for i in recordings_container.get_children():
		if i == recording:
			recording_dialog.display_text(recordings[recordings.keys()[index]])
			return
		index += 1
	
func display_recording_stop():
	recording_dialog.reset()
