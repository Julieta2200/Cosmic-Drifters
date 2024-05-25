extends Node2D

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]
var rng = RandomNumberGenerator.new()

func add_plate():
	for plate in get_children():
		if !plate.visible:
			plate.texture = load(plates[rng.randf_range(0,plates.size())])
			plate.visible = true
			return
	
	
func remove_plate():
	for plate in get_children():
		if plate.visible:
			plate.visible = false
			return
