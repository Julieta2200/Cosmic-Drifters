class_name Computer extends Node2D

signal open_food_menu(table)

enum {PENDING, ORDERED}
var tables = []

@onready var use_point = $use_point

func add_table(table):
	tables.append({"instance": table, "status": PENDING})
	$status.visible = true

func order_inserted(table):
	for t in tables:
		if t["instance"] == table:
			t["status"] = ORDERED
	$status.visible = false
	for t in tables:
		if t["status"] == PENDING:
			$status.visible = true

func action_complete(_action, player):
	for table in tables:
#		if table["status"] == PENDING:
			emit_signal("open_food_menu", table["instance"])
			return
	
	player.busy = false
	
