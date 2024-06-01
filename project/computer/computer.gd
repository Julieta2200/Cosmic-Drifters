extends Node2D

class_name Computer

enum {PENDING}
var tables = []

@onready var use_point = $use_point

func add_table(table):
	tables.append({"instance": table, "status": PENDING})
	$status.visible = true

func action_complete(_action, player):
	print("open_computer")
	pass
	
