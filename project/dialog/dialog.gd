class_name Dialog extends Control

func appear(text: String , name :String , sprite : Texture):
	$background/text.text = text
	$background/name.text = name
	$background/stroke/sprite.texture = sprite
	visible = true
	
func disappear():
	visible = false
