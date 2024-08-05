class_name Desk extends Node2D

var plate_textures = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

@onready var use_point = $use_point
@onready var orders_menu: OrdersMenu = $"../../CanvasLayer/orders_menu"
var player: Player
var table : Table
var plates = {}
var _rng = RandomNumberGenerator.new()

func open(p: Player):
	player = p
	orders_menu.load_tables(plates, player)
	orders_menu.visible = true

func add_plate(table: Table):
	var plate
	self.table = table
	for p in $plates.get_children():
		if !p.visible:
			plate = p
			break
	plate.texture = load(plate_textures[_rng.randf_range(0,plate_textures.size())])
	plate.visible = true
	plates[table] = {"plate": plate}
	var text = add_to_board(table)
	plates[table]["text"] = text


func remove_plate(table: Table):
	plates[table]["plate"].visible = false
	if plates[table].has("text"):
		remove_from_board(plates[table]["text"])
	plates.erase(table)
	if table.for_lumina():
		orders_menu.load_tables(plates, player)
	


func add_to_board(table: Table):
	$board.visible = true
	for text in $board/texts.get_children():
		if !text.visible:
			text.text = "0" + str(table.number)
			text.visible = true
			return text

func remove_from_board(text):
	text.visible = false
	for t in $board/texts.get_children():
		if t.visible:
			return
	$board.visible = false


func _on_clickable_component_delete_outline():
	$outline.visible = false


func _on_clickable_component_outline():
	if $board.visible && table.for_lumina():
		$outline.visible = true
