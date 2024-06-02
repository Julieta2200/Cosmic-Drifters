extends Control

var s
var table
@onready var selected_foods = $main_panel/selected_foods
@onready var ok_btn = $ok
func _ready():
		fill_food_container(Food.HOT_DISH)

func _on_hot_dishes_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes1.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu1.png")
			fill_food_container(Food.HOT_DISH)


func _on_dessert_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert1.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks2.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu2.png")
			fill_food_container(Food.DESSERT)



func _on_drinks_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$main_panel/hot_dishes.texture = load("res://assets/Menu_UI/Panel_Hot_Dishes/Hot_dishes2.png")
			$main_panel/dessert.texture = load("res://assets/Menu_UI/Panel_Dessert/Dessert2.png")
			$main_panel/drinks.texture = load("res://assets/Menu_UI/Panel_Drinks/Drinks1.png")
			$main_panel.texture = load("res://assets/Menu_UI/Menu/Menu3.png")
			fill_food_container(Food.DRINK)

func fill_food_container(food_type):
	var index = 0
	var placeholders = $main_panel/food_container.get_children()
	for placeholder in placeholders:
		placeholder.set_food(null, self)
		
	for food in Food.foods:
		if Food.get_food(food)["type"] == food_type:
			placeholders[index].set_food(load(Food.get_food(food)["texture"]), self)
			index += 1
		
func select_food(food):
	for selected_food in selected_foods.get_children():
		if selected_food.visible and selected_food.get_food() == null:
			selected_food.set_food(food, self)
			check_ok_status()
			return
	
func set_table(t):
	table = t
	$table_number/Label.text = "N " + str(table.number)
	set_selected_foods()

func set_selected_foods():
	selected_foods.get_children()[2].visible = len(table.chairs.get_children()) == 4
	selected_foods.get_children()[3].visible = len(table.chairs.get_children()) == 4
	

func check_ok_status():
	for selected_food in selected_foods.get_children():
		if selected_food.visible and selected_food.get_food() == null:
			ok_btn.disabled = true
			return
	
	ok_btn.disabled = false
	
