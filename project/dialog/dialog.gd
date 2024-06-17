class_name Dialog extends Control

var showNameIndex = 0
var fname = ""
var showTextIndex = 0
var ftext = ""

func appear(text: String , name :String , sprite : Texture):
	ftext = text
	fname = name
	showTextIndex = 0
	showNameIndex = 0
	$background/stroke/sprite.texture = sprite
	visible = true
	
func disappear():
	visible = false

func _process(delta):
	if showNameIndex <= fname.length():
		$background/name.text = fname.substr(0, showNameIndex)
		showNameIndex += 1
	elif showTextIndex <= ftext.length():
		$background/text.text = ftext.substr(0, showTextIndex)
		showTextIndex += 1
