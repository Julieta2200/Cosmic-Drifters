extends Node2D

class_name Food

var rng = RandomNumberGenerator.new()

var selected_food_index = -1

@onready var food_sp = $food
@onready var cloud = $cloud
var action
var level
var table

var prepared: bool = false
enum {HOT_DISH, DESSERT, DRINK}

static var food_objs = {
	"cake_1": {"name": "cake_1", "texture": "res://assets/Food/Dessert/cake_1.png", "type": DESSERT},
	"cake_2": {"name": "cake_2", "texture": "res://assets/Food/Dessert/cake_2.png", "type": DESSERT},
	"cracker": {"name": "cracker", "texture": "res://assets/Food/Dessert/cracker.png", "type": DESSERT},
	"easter_cake": {"name": "easter_cake", "texture": "res://assets/Food/Dessert/easter_cake.png", "type": DESSERT},
	"ice_cream_1": {"name": "ice_cream_1", "texture": "res://assets/Food/Dessert/ice_cream_1.png", "type": DESSERT},
	"ice_cream_2": {"name": "ice_cream_2", "texture": "res://assets/Food/Dessert/ice_cream_2.png", "type": DESSERT},
	"muffin_1": {"name": "muffin_1", "texture": "res://assets/Food/Dessert/muffin_1.png", "type": DESSERT},
	"muffin_2": {"name": "muffin_2", "texture": "res://assets/Food/Dessert/muffin_2.png", "type": DESSERT},
	"pancakes": {"name": "pancakes", "texture": "res://assets/Food/Dessert/pancakes.png", "type": DESSERT},
	"roll": {"name": "roll", "texture": "res://assets/Food/Dessert/roll.png", "type": DESSERT},
	"beer": {"name": "beer", "texture": "res://assets/Food/Drinks/beer.png", "type": DRINK},
	"cocktail": {"name": "cocktail", "texture": "res://assets/Food/Drinks/cocktail.png", "type": DRINK},
	"cocoa": {"name": "cocoa", "texture": "res://assets/Food/Drinks/cocoa.png", "type": DRINK},
	"coffee": {"name": "coffee", "texture": "res://assets/Food/Drinks/coffee.png", "type": DRINK},
	"green_tea": {"name": "green_tea", "texture": "res://assets/Food/Drinks/green_tea.png", "type": DRINK},
	"juice_1": {"name": "juice_1", "texture": "res://assets/Food/Drinks/juice_1.png", "type": DRINK},
	"juice_2": {"name": "juice_2", "texture": "res://assets/Food/Drinks/juice_2.png", "type": DRINK},
	"water": {"name": "water", "texture": "res://assets/Food/Drinks/water.png", "type": DRINK},
	"beacon": {"name": "beacon", "texture": "res://assets/Food/Hot_dish/becon.png", "type": HOT_DISH},
	"beef": {"name": "beef", "texture": "res://assets/Food/Hot_dish/beef.png", "type": HOT_DISH},
	"burger": {"name": "burger", "texture": "res://assets/Food/Hot_dish/burger.png", "type": HOT_DISH},
	"chicken": {"name": "chicken", "texture": "res://assets/Food/Hot_dish/chicken.png", "type": HOT_DISH},
	"hot_dog": {"name": "hot_dog", "texture": "res://assets/Food/Hot_dish/hot_dog.png", "type": HOT_DISH},
	"mushroom": {"name": "mushroom", "texture": "res://assets/Food/Hot_dish/Mushroom.png", "type": HOT_DISH},
	"omelette": {"name": "omelette", "texture": "res://assets/Food/Hot_dish/omelette.png", "type": HOT_DISH},
	"pizza": {"name": "pizza", "texture": "res://assets/Food/Hot_dish/pizza.png", "type": HOT_DISH},
	"ramen": {"name": "ramen", "texture": "res://assets/Food/Hot_dish/ramen.png", "type": HOT_DISH},
	"rice_balls1": {"name": "rice_balls1", "texture": "res://assets/Food/Hot_dish/rice_balls1.png", "type": HOT_DISH},
	"rice_balls2": {"name": "rice_balls2", "texture": "res://assets/Food/Hot_dish/rice_balls2.png", "type": HOT_DISH},
	"rice_balls3": {"name": "rice_balls3", "texture": "res://assets/Food/Hot_dish/rice_balls3.png", "type": HOT_DISH},
	"rice_balls4": {"name": "rice_balls4", "texture": "res://assets/Food/Hot_dish/rice_balls4.png", "type": HOT_DISH},
	"tuna": {"name": "tuna", "texture": "res://assets/Food/Hot_dish/tuna.png", "type": HOT_DISH}
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
	"beacon",
	"beef",
	"burger",
	"chicken",
	"hot_dog",
	"mushroom",
	"omelette",
	"pizza",
	"ramen",
	"rice_balls1",
	"rice_balls2",
	"rice_balls3",
	"rice_balls4",
	"tuna"
]

func get_selected_food_index():
	return selected_food_index

func generate(flipped):
	selected_food_index = rng.randf_range(0,foods.size())
	var food = Food.get_food(Food.get_food_by_index(selected_food_index))
	food_sp.texture = load(food["texture"])
	if flipped:
		cloud.offset.x= -30
		food_sp.offset.x = -32
		cloud.flip_h = true
	visible = true

static func get_food(food_name):
	return food_objs[food_name]
	
static func get_food_by_index(food_index):
	return Food.foods[food_index]
