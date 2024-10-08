class_name Dialog extends Control

var _show_name_index = 0
var _name = ""
var _show_text_index = 0
var _text = ""
var highlight_text_color = "[color=#d2fbfb]"
var normal_text_color = "[color=#d6d6d6]"

@onready var _timer = $Timer

var have_text: bool

func appear(text: String , character_name :String , sprite : Texture):
	_text = highlight_text(text)
	_name = character_name
	_show_text_index = 0
	_show_name_index = 0
	visible = true
	$background/stroke/sprite.texture = sprite
	$background/name.text = ""
	$background/text.text = ""
	write_text(0.02)

func reset():
	visible = false
	have_text = false
	
func disappear():
	visible = false


func show_panel():
	visible = true


func write_text(wait_time):
	_timer.wait_time = wait_time
	_timer.start()

func _on_timer_timeout():
	if _show_name_index < _name.length():
		_show_name_index += 1
		$background/name.text = _name.substr(0, _show_name_index)
	elif _show_text_index < _text.length():
		if _text[_show_text_index] == "[":
			if _text.substr(_show_text_index, highlight_text_color.length())  == highlight_text_color :
				_show_text_index = coloring_index(_show_text_index,highlight_text_color)
			else:
				_show_text_index = coloring_index(_show_text_index,normal_text_color)
		else:
			_show_text_index += 1
			$background/text.text = "\n"+_text.substr(0, _show_text_index)
	else:
		_timer.stop()

func highlight_text(text) -> String:
	var new_text = ""
	for i in text:
		if i == "(": 
			new_text += highlight_text_color
		elif i == ")":
			new_text += normal_text_color
		else:
			new_text += i
	return new_text

func coloring_index(_show_text_index,text_color) -> int:
	var i = _show_text_index 
	while _show_text_index <  i +  text_color.length():
		_show_text_index += 1 
	return _show_text_index
