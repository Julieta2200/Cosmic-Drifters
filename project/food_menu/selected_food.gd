extends Button

var menu
var food

func get_food():
	return food

func set_food(f, m):
	food = f
	if food != null:
		$TextureRect.texture = load(food["texture"])
	else:
		$TextureRect.texture = null
	menu = m



func _on_button_down():
	$TextureRect.texture = null
	food = null
	menu.check_ok_status()
