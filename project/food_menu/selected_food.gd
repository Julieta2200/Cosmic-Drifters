extends Button

var menu

func get_food():
	return $TextureRect.texture

func set_food(texture, m):
	$TextureRect.texture = texture
	menu = m



func _on_button_down():
	$TextureRect.texture = null
	menu.check_ok_status()
