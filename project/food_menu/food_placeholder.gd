extends Button

var menu

func set_food(texture, m):
	$TextureRect.texture = texture
	menu = m


func _on_button_down():
	menu.select_food($TextureRect.texture)
