extends Node2D

@export var chairs: Array[Node2D]
@onready var plate = $plate
var rng = RandomNumberGenerator.new()

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

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

func add_plate(i: int):
	plate.get_child(i).texture = load(plates[rng.randf_range(0,plates.size())])
	plate.get_child(i).visible = true
	
func remove_plate(i: int):
	plate.get_child(i).visible = false
	
