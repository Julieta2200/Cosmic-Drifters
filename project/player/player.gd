extends Character

class_name Player

var busy: bool = false

var desk
var computer

@export var ui: Control

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

func ask_order(table):
	if table.status != table.STATUS_WAITING1:
		return	
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(table, serve_point, "ask_order")

func input_order(c):
	computer = c
	busy = true
	walk_to(computer, computer.use_point.global_position, "input_order")

func pick_order(d):
	desk = d
	busy = true
	walk_to(desk, desk.use_point.global_position, "pick_order")

func pick_plates(table):
	desk.remove_plate(table.group)
	ui.add_item(table)

func have_empty_slot():
	return ui.items.size() != 3

func open_characters_panel():
	busy = true
	print("open")
	pass

func _on_munchkin_morsel_pressed():
	pass # Replace with function body.


func _on_frost_dumpling_pressed():
	pass # Replace with function body.


func _on_bunnyboo_sipper_pressed():
	pass # Replace with function body.


func _on_cerulean_hopper_pressed():
	pass # Replace with function body.


func _on_twilight_tarsier_pressed():
	pass # Replace with function body.


func _on_prismarity_pressed():
	pass # Replace with function body.
