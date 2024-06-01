extends Button

func get_food():
	return $TextureRect.texture

func set_food(texture):
	$TextureRect.texture = texture
