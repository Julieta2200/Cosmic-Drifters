extends Node2D

class_name Computer

enum {PENDING, ORDERED}
var tables: Array[Table] = []

@onready var use_point = $use_point
@onready var food_menu: FoodMenu = $"../../CanvasLayer/food_menu"

func add_table(table):
	tables.append(table)
	$status.visible = true

func order_inserted():
	tables.remove_at(0)
	$status.visible = false

func open(player):
	if len(tables) == 0:
		player.busy = false
		return
		
	var table = tables[0]
	food_menu.set_table(table)
	food_menu.visible = true

func highlight():
	if $status.visible:
		$outline.visible = true
