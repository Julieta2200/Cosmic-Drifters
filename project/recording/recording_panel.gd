extends Control

var recording_scene 
var recordings

@onready var recording_dialog = $"../recording_dialog"
@onready var recordings_container = $panel/ScrollContainer/VBoxContainer


func stoping():
	for i in recordings_container.get_children():
		if i.butten_state:
			i.change_texture(i.play_button)
			i.recording_animation.stop()

func open(r : Array):
	recordings = r
	for i in range(recordings.size()):
		recording_scene = preload("res://project/recording/recording_number.tscn").instantiate()
		recordings_container.add_child(recording_scene)
		recording_scene.change(i,recordings[i]["group"].name)
	visible = true
	
func display_recording(recording):
	recording_dialog.text_index = 0
	var index = 0
	for i in recordings_container.get_children():
		if i == recording:
			recording_dialog.display_text(recordings[index]["conversation"])
			return
		index += 1
	
func display_recording_stop():
	recording_dialog.reset()

func delete_recording(recording):
	var index = 0
	for i in recordings_container.get_children():
		if i == recording:
			recordings.remove_at(index)
		i.queue_free()
		index += 1
	recording_dialog.reset()
	stoping()
	open(recordings)
	

func _on_report_pressed():
	pass # Replace with function body.
