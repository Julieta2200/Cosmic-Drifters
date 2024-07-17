class_name Player extends Waiter

var desk: Desk
var computer: Computer
var expected_mask
var previous_character

signal ready_input_order
signal ready_choose_order

@export var ui: TopUI
@onready var enemy_markers = $enemy_markers

func check_queue():
	pass

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

func interact_table(table):
	if table.group != null:
		match table.group.current_status:
			table.group.STATUS_ASKING_FOR_WAITER:
				walk_to_table(table, ready_take_order)
			table.group.STATUS_WAITING_FOR_FOOD:
				walk_to_table(table, ready_give_order)
			table.group.STATUS_WAITING_FOR_CHECK:
				walk_to_table(table, ready_give_check)

func give_order(table: Table):
	var index = ui.get_item_index(table)
	if index == -1:
		busy = false
		return
	super.give_order(table)
	ui.remove_item(index)

func walk_to_table(table: Table, sig: Signal):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(serve_point, sig, table)
	
func ordered(table):
	busy = false
	level.computer.add_table(table)


func walk_to_computer(c: Computer):
	computer = c
	busy = true
	walk_to(computer.use_point.global_position, ready_input_order)

func input_order():
	computer.open(self)

func walk_to_desk(d: Desk):
	desk = d
	busy = true
	walk_to(desk.use_point.global_position, ready_choose_order)

func pick_plates(table):
	desk.remove_plate(table)
	ui.add_item(table)

func have_empty_slot():
	return ui.items.size() != 3

func open_characters_panel():
	busy = true
	$characters_panel.visible = true
	pass

func morph(mask = LUMINA):
	$characters_panel.visible = false
	$AnimatedSprite2D.play("lumina")
	expected_mask = mask

func set_mask(mask = LUMINA):
	current_mask = mask
	animation()

func _on_munchkin_morsel_pressed():
	change_character($characters_panel/munchkin_morsel/TextureRect,MORSEL)
	previous_character = load("res://assets/Munchkin Morsels/base.png")

func _on_frost_dumpling_pressed():
	change_character($characters_panel/frost_dumpling/TextureRect,FROST)
	previous_character = load("res://assets/Frost Dumplings/base.png")


func _on_bunnyboo_sipper_pressed():
	change_character($characters_panel/bunnyboo_sipper/TextureRect,BUNNYBOO)
	previous_character = load("res://assets/Bunnyboo Sippers/base.png")



func _on_cerulean_hopper_pressed():
	change_character($characters_panel/cerulean_hopper/TextureRect,HOPPER)
	previous_character = load("res://assets/Cerulean Hoppers/base.png")


func _on_twilight_tarsier_pressed():
	change_character($characters_panel/twilight_tarsier/TextureRect,TWILIGHT)
	previous_character = load("res://assets/Twilight Tarsiers/base.png")

func _on_prismarity_pressed():
	change_character($characters_panel/prismarity/TextureRect,PRISMA)
	previous_character = load("res://assets/Prismarities/base.png")
	

func _on_oliver_pressed():
	change_character($characters_panel/oliver/TextureRect,OLIVER)
	previous_character = load("res://assets/Security guard/Oliver_16px.png")


func _on_animated_sprite_2d_animation_finished():
	set_mask(expected_mask)
	busy = false

func change_character(character, _character_name):
	if character.texture != character_sprite:
		for i in $characters_panel.get_child_count():
			if i > 0 :
				if $characters_panel.get_child(i).get_child(0).texture == character_sprite:
					$characters_panel.get_child(i).get_child(0).texture = previous_character
					
		character.texture = character_sprite
		morph(_character_name)
	else:
		morph(LUMINA)
		character.texture = previous_character



func _on_ready_input_order():
	input_order()

func _on_ready_choose_order():
	desk.open(self)

func walk_stop():
	if !path.is_empty():
		path = []
	busy = true
	animation()
	
