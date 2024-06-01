extends Node2D

class_name Food

var rng = RandomNumberGenerator.new()

@onready var food_sp = $food
@onready var cloud = $cloud
var action
var level
var table

var prepared: bool = false

static var food_textures = {
	"cake_1": "res://assets/Food/Dessert/cake_1.png",
	"cake_2": "res://assets/Food/Dessert/cake_2.png",
	"cracker": "res://assets/Food/Dessert/cracker.png",
	"easter_cake": "res://assets/Food/Dessert/easter_cake.png",
	"ice_cream_1": "res://assets/Food/Dessert/ice_cream_1.png",
	"ice_cream_2": "res://assets/Food/Dessert/ice_cream_2.png",
	"muffin_1": "res://assets/Food/Dessert/muffin_1.png",
	"muffin_2": "res://assets/Food/Dessert/muffin_2.png",
	"pancakes": "res://assets/Food/Dessert/pancakes.png",
	"roll": "res://assets/Food/Dessert/roll.png",
	"beer": "res://assets/Food/Drinks/beer.png",
	"cocktail": "res://assets/Food/Drinks/cocktail.png",
	"cocoa": "res://assets/Food/Drinks/cocoa.png",
	"coffee": "res://assets/Food/Drinks/coffee.png",
	"green_tea": "res://assets/Food/Drinks/green_tea.png",
	"juice_1": "res://assets/Food/Drinks/juice_1.png",
	"juice_2": "res://assets/Food/Drinks/juice_2.png",
	"water": "res://assets/Food/Drinks/water.png",
	"apple_1": "res://assets/Food/Fruits/apple_1.png",
	"apple_2": "res://assets/Food/Fruits/apple_2.png",
	"orange": "res://assets/Food/Fruits/Orange.png",
	"strawberry": "res://assets/Food/Fruits/strawberry.png",
	"watermelon": "res://assets/Food/Fruits/watermelon.png",
	"beacon": "res://assets/Food/Hot_dish/becon.png",
	"beef": "res://assets/Food/Hot_dish/beef.png",
	"burger": "res://assets/Food/Hot_dish/burger.png",
	"chicken": "res://assets/Food/Hot_dish/chicken.png",
	"hot_dog": "res://assets/Food/Hot_dish/hot_dog.png",
	"mushroom": "res://assets/Food/Hot_dish/Mushroom.png",
	"omelette": "res://assets/Food/Hot_dish/omelette.png",
	"pepeer": "res://assets/Food/Hot_dish/pepper.png",
	"pizza": "res://assets/Food/Hot_dish/pizza.png",
	"ramen": "res://assets/Food/Hot_dish/ramen.png",
	"rice_balls1": "res://assets/Food/Hot_dish/rice_balls1.png",
	"rice_balls2": "res://assets/Food/Hot_dish/rice_balls2.png",
	"rice_balls3": "res://assets/Food/Hot_dish/rice_balls3.png",
	"rice_balls4": "res://assets/Food/Hot_dish/rice_balls4.png",
	"tuna": "res://assets/Food/Hot_dish/tuna.png"
}

static var foods = [
	"cake_1",
	"cake_2",
	"cracker",
	"easter_cake",
	"ice_cream_1",
	"ice_cream_2",
	"muffin_1",
	"muffin_2",
	"pancakes",
	"roll",
	"beer",
	"cocktail",
	"cocoa",
	"coffee",
	"green_tea",
	"juice_1",
	"juice_2",
	"water",
	"apple_1",
	"apple_2",
	"orange",
	"strawberry",
	"watermelon",
	"beacon",
	"beef",
	"burger",
	"chicken",
	"hot_dog",
	"mushroom",
	"omelette",
	"pepeer",
	"pizza",
	"ramen",
	"rice_balls1",
	"rice_balls2",
	"rice_balls3",
	"rice_balls4",
	"tuna"
]

func generate(flipped):
	var food = Food.foods[rng.randf_range(0,foods.size())]
	food_sp.texture = load(Food.food_textures[food])
	if flipped:
		cloud.offset.x= -30
		food_sp.offset.x = -32
		cloud.flip_h = true
	visible = true
