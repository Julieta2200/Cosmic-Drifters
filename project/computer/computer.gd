extends Node2D

class_name Computer

enum {PENDING}
var tables = []

func add_table(table):
	tables.append({"instance": table, "status": PENDING})
	$status.visible = true

