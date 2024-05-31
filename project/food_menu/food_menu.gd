extends Control

var dessert = ["res://assets/Food/Dessert/cake_1.png","res://assets/Food/Dessert/cake_2.png",
 				"res://assets/Food/Dessert/cracker.png","res://assets/Food/Dessert/easter_cake.png",
				"res://assets/Food/Dessert/ice_cream_1.png","res://assets/Food/Dessert/ice_cream_2.png",
				"res://assets/Food/Dessert/muffin_1.png","res://assets/Food/Dessert/muffin_2.png",
				"res://assets/Food/Dessert/pancakes.png","res://assets/Food/Dessert/roll.png"]
				
var drinks = ["res://assets/Food/Drinks/beer.png","res://assets/Food/Drinks/cocktail.png",
				"res://assets/Food/Drinks/cocoa.png","res://assets/Food/Drinks/coffee.png",
				"res://assets/Food/Drinks/green_tea.png","res://assets/Food/Drinks/juice_1.png",
				"res://assets/Food/Drinks/juice_2.png","res://assets/Food/Drinks/water.png"]
			
var hot_dishes = ["res://assets/Food/Hot_dish/becon.png","res://assets/Food/Hot_dish/beef.png",
					"res://assets/Food/Hot_dish/burger.png","res://assets/Food/Hot_dish/chicken.png",
					"res://assets/Food/Hot_dish/hot_dog.png","res://assets/Food/Hot_dish/Mushroom.png",
					"res://assets/Food/Hot_dish/omelette.png","res://assets/Food/Hot_dish/pepper.png",
					"res://assets/Food/Hot_dish/pizza.png","res://assets/Food/Hot_dish/ramen.png",
					"res://assets/Food/Hot_dish/rice_balls1.png","res://assets/Food/Hot_dish/rice_balls2.png",
					"res://assets/Food/Hot_dish/rice_balls3.png","res://assets/Food/Hot_dish/rice_balls4.png",
					"res://assets/Food/Hot_dish/tuna.png"]

func _on_hot_dishes_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes1.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu1.png")
			fill_food_container(hot_dishes)


func _on_dessert_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert1.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu2.png")
			fill_food_container(dessert)



func _on_drinks_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks1.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu3.png")
			fill_food_container(drinks)

func fill_food_container(food_array):
	var index = 0
	for placeholder in $main_panel/food_container.get_children():
		if  index < food_array.size():
			placeholder.get_child(0).texture = load(food_array[index]) 
		else:
			placeholder.get_child(0).texture = Enemy
		index=index+1
