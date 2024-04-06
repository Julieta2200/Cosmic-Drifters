extends Node2D

class_name Table

@onready var chairs = $table/chairs
var chair_add = {}
var place = true

func add_character(player):
	for chair in chairs.get_children():
		if chair.visible == true:
			chair_add[player] = chair
			return chair
	if chair_add.size() == chairs.get_children().size():
		place = false
	else:
		place = true
		

func place_character(player):
#	if chair_add.size() == chairs.get_children().size():
	if  chair_add.has(player):
		chair_add[player].visible = true
		chair_add.erase(player)
