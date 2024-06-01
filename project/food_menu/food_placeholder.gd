extends Button

func set_food(texture):
	$TextureRect.texture = texture


func _on_button_down():
	print($TextureRect.texture)
