extends Dialog

@onready var recording_panel = $"../recording_panel"

var recording_array = []
var text_index = 0

func display_text(array):
	recording_array = array
	_text = highlight_text(recording_array[text_index])
	_show_text_index = 0
	_show_name_index = 0
	visible = true
	$background/text.text = ""
	write_text(0.02)

func _on_next_button_pressed():
	if text_index < recording_array.size() - 1:
		text_index += 1
		display_text(recording_array)
	else:
		text_index = 0
