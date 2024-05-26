extends Node2D


@onready var food_sp = $food
var action
var level

var foods = ["res://assets/Food/Dessert/cake_1.png","res://assets/Food/Dessert/cake_2.png",
 			"res://assets/Food/Dessert/cracker.png","res://assets/Food/Dessert/easter_cake.png",
			"res://assets/Food/Dessert/ice_cream_1.png","res://assets/Food/Dessert/ice_cream_2.png",
			"res://assets/Food/Dessert/muffin_1.png","res://assets/Food/Dessert/muffin_2.png",
			"res://assets/Food/Dessert/pancakes.png","res://assets/Food/Dessert/roll.png",
			"res://assets/Food/Drinks/beer.png","res://assets/Food/Drinks/cocktail.png",
			"res://assets/Food/Drinks/cocoa.png","res://assets/Food/Drinks/coffee.png",
			"res://assets/Food/Drinks/green_tea.png","res://assets/Food/Drinks/juice_1.png",
			"res://assets/Food/Drinks/juice_2.png","res://assets/Food/Drinks/water.png",
			"res://assets/Food/Fruits/apple_1.png","res://assets/Food/Fruits/apple_2.png",
			"res://assets/Food/Fruits/Orange.png","res://assets/Food/Fruits/strawberry.png",
			"res://assets/Food/Fruits/watermelon.png","res://assets/Food/Hot_dish/becon.png",
			"res://assets/Food/Hot_dish/beef.png","res://assets/Food/Hot_dish/burger.png",
			"res://assets/Food/Hot_dish/chicken.png","res://assets/Food/Hot_dish/hot_dog.png",
			"res://assets/Food/Hot_dish/Mushroom.png","res://assets/Food/Hot_dish/omelette.png",
			"res://assets/Food/Hot_dish/pepper.png","res://assets/Food/Hot_dish/pizza.png",
			"res://assets/Food/Hot_dish/ramen.png","res://assets/Food/Hot_dish/rice_balls1.png",
			"res://assets/Food/Hot_dish/rice_balls2.png","res://assets/Food/Hot_dish/rice_balls3.png",
			"res://assets/Food/Hot_dish/rice_balls4.png","res://assets/Food/Hot_dish/tuna.png"]

func prepare(a, lvl):
	$Timer.wait_time = 10
	$Timer.start()
	action = a
	level = lvl


func _on_timer_timeout():
	level.action_complete(action+":order_prepared", null)
