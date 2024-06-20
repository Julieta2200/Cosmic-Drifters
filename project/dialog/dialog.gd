class_name Dialog extends Control

var _show_name_index = 0
var _name = ""
var _show_text_index = 0
var _text = ""

@onready var _timer = $Timer

func appear(text: String , character_name :String , sprite : Texture):
	_text = text
	_name = character_name
	_show_text_index = 0
	_show_name_index = 0
	$background/stroke/sprite.texture = sprite
	visible = true
	$background/name.text = ""
	$background/text.text = ""
	write_text(0.02)
	
func disappear():
	visible = false
	
func write_text(wait_time):
	_timer.wait_time = wait_time
	_timer.start()

func _on_timer_timeout():
	if _show_name_index <= _name.length():
		$background/name.text = _name.substr(0, _show_name_index)
		_show_name_index += 1
	elif _show_text_index <= _text.length():
		$background/text.text = _text.substr(0, _show_text_index)
		_show_text_index += 1
	else:
		_timer.stop()
