extends Node2D

class_name Computer

var pending_tables = []

func _process(_delta):
	if len(pending_tables) > 0:
		if !$status.visible:
			$status.visible = true
	else:
		if $status.visible:
			$status.visible = false

func add_table(table):
	pending_tables.append(table)

