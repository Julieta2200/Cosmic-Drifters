extends Node2D

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]
var rng = RandomNumberGenerator.new()

var for_lumina = {}

func add_plate(group):
	for plate in get_children():
		if !plate.visible:
			plate.texture = load(plates[rng.randf_range(0,plates.size())])
			plate.visible = true
			if group.has("for_lumina"):
				for_lumina[plate] = true
				update_board(group)
			return
	
	
func remove_plate():
	for plate in get_children():
		if plate.visible and !for_lumina.has(plate):
			plate.visible = false
			return

func update_board(group):
	for text in $board/texts.get_children():
		if !text.visible:
			text.text = "N " + str(group["table"].number)
			text.visible = true
			break
	$board.visible = true
