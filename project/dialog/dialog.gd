class_name Dialog extends Control

func appear(text: String):
	$background/text.text = text
	visible = true
	
func disappear():
	visible = false
