extends Character

class_name Player

var busy: bool = false

var desk
var computer
var expected_mask
var previous_character

@export var ui: Control

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

func interact_table(table):
	match table.status:
		table.STATUS_WAITING1:
			ask_order(table)
		table.STATUS_WAITING_FOR_FOOD:
			serve_food(table)

func ask_order(table):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(table, serve_point, "ask_order")
	
func get_food(table):
	var index = ui.get_item_index(table)
	if index == -1:
		busy = false
		return
	print(index)
	ui.remove_item(index)
	table.add_plates()
	busy = false
		

func serve_food(table):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(table, serve_point, "serve_food")

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

func change_character(character, name):
	if character.texture != character_sprite:
		for i in $characters_panel.get_child_count():
			if i > 0 :
				if $characters_panel.get_child(i).get_child(0).texture == character_sprite:
					$characters_panel.get_child(i).get_child(0).texture = previous_character
					
		character.texture = character_sprite
		morph(name)
	else:
		morph(LUMINA)
		character.texture = previous_character

