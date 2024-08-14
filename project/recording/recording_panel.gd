extends Control

var recording_scene 
var groups : Array
var conversations : Array

@onready var recording_dialog = $"../recording_dialog"
@onready var recordings_container = $panel/ScrollContainer/VBoxContainer


func stoping():
	for i in recordings_container.get_children():
		if i.butten_state:
			i.change_texture(i.play_button)
			i.recording_animation.stop()

func open(recordings : Dictionary):
	groups = recordings["group"]
	conversations = recordings["conversation"]
	for i in range(groups.size()):
		recording_scene = preload("res://project/recording/recording_number.tscn").instantiate()
		recordings_container.add_child(recording_scene)
		recording_scene.change(i,groups[i].name)
	visible = true
	
func display_recording(recording):
	recording_dialog.text_index = 0
	var index = 0
	for i in recordings_container.get_children():
		if i == recording:
			recording_dialog.display_text(conversations[index])
			return
		index += 1
	
func display_recording_stop():
	recording_dialog.reset()

func arrange():
	if recordings_container.get_child_count() != 0:
		for i in range(recordings_container.get_child_count() - 1):
			recording_scene.change(i,groups[i].name)
		recording_dialog.reset()

func delete_recording(recording):
	var index = 0
	for i in recordings_container.get_children():
		if i == recording:
			groups.remove_at(index)
			conversations.remove_at(index)
			return
		index += 1

func _on_report_pressed():
	pass # Replace with function body.
