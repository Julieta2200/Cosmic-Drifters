extends Control

func _on_hot_dishes_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes1.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu1.png")


func _on_dessert_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert1.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu2.png")



func _on_drinks_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks1.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu3.png")


