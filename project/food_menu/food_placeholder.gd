extends Button

var menu
var food

func set_food(f, m):
	food = f
	menu = m
	if food == null:
		$TextureRect.texture = null
		return
	$TextureRect.texture = load(food["texture"])


func _on_button_down():
	menu.select_food(food)
