extends Node2D

@onready var plate = $plate
var rng = RandomNumberGenerator.new()

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

func add_character(ch: Character):
	for chair in $chairs.get_children():
		if chair.visible:
			ch.position = chair.position
			chair.visible = false
			return

func get_chair(index):
	return $chairs.get_children()[index]
	
func get_serve_point():
	return $serve_point.global_position

func sit_down(index):
	$chairs.get_children()[index].visible = false
	
func get_up(index):
	$chairs.get_children()[index].visible = true

func add_plates():
	for p in plate.get_children():
		p.texture = load(plates[rng.randf_range(0,plates.size())])
		p.visible = true
	
func remove_plates():
	for p in plate.get_children():
		p.visible = false
	
