extends Node2D

@export var chairs: Array[Node2D]

func add_character(ch: Character):
	for chair in chairs:
		if chair.visible:
			ch.position = chair.position
			chair.visible = false
			return

func get_chair(index):
	return chairs[index]
