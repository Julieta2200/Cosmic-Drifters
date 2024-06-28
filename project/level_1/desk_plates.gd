extends Node2D

class_name Desk

var plate_textures = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]
var rng = RandomNumberGenerator.new()
@onready var use_point = $use_point
@onready var orders_menu = $"../../CanvasLayer/orders_menu"
var player 

var plates = {}


func add_plate(group):
	var plate
	for p in $plates.get_children():
		if !p.visible:
			plate = p
			break
	plate.texture = load(plate_textures[rng.randf_range(0,plate_textures.size())])
	plate.visible = true
	plates[group] = {"plate": plate}
	if group._for_lumina:
		var text = add_to_board(group)
		plates[group]["text"] = text	
	
	
	
func remove_plate(group):
	plates[group]["plate"].visible = false
	if plates[group].has("text"):
		remove_from_board(plates[group]["text"])
	plates.erase(group)
	orders_menu.load_tables(plates, player)
	


func add_to_board(group):
	$board.visible = true
	for text in $board/texts.get_children():
		if !text.visible:
			text.text = "N " + str(group._table.number)
			text.visible = true
			return text

func remove_from_board(text):
	text.visible = false
	for t in $board/texts.get_children():
		if t.visible:
			return
	$board.visible = false

func action_complete(_action, p):
	player = p
	orders_menu.load_tables(plates, player)
	orders_menu.visible = true
	pass
