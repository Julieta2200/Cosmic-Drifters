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
	
func get_serve_point():
	return $serve_point.global_position

func sit_down(index):
	chairs[index].visible = false
	
func get_up(index):
	chairs[index].visible = true
