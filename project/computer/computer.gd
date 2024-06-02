extends Node2D

class_name Computer

enum {PENDING, ORDERED}
var tables = []

@onready var use_point = $use_point
@onready var food_menu = $"../../CanvasLayer/food_menu"

func add_table(table):
	tables.append({"instance": table, "status": PENDING})
	$status.visible = true

func order_inserted(table):
	for t in tables:
		if t["instance"] == table:
			t["status"] = ORDERED
	$status.visible = false
	for t in tables:
		if table["status"] == PENDING:
			$status.visible = true

func action_complete(_action, player):
	for table in tables:
		if table["status"] == PENDING:
			food_menu.set_table(table["instance"])
			food_menu.visible = true
			return
	
	player.busy = false
	
