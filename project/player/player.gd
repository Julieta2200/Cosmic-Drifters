extends Character

class_name Player

var busy: bool = false

var desk
var computer
var expected_mask

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
	$characters_panel.visible = true
	pass

func morph(mask = LUMINA):
	$AnimationPlayer.play("morph")
	expected_mask = mask
	

func set_mask(mask = LUMINA):
	current_mask = mask
	animation()

func _on_munchkin_morsel_pressed():
	morph(MORSEL)
	print(current_mask)
	$characters_panel.visible = false


func _on_frost_dumpling_pressed():
	morph(FROST)
	$characters_panel.visible = false


func _on_bunnyboo_sipper_pressed():
	morph(BUNNYBOO)
	$characters_panel.visible = false


func _on_cerulean_hopper_pressed():
	morph(HOPPER)
	$characters_panel.visible = false


func _on_twilight_tarsier_pressed():
	morph(TWILIGHT)
	$characters_panel.visible = false


func _on_prismarity_pressed():
	morph(PRISMA)
	$characters_panel.visible = false


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"morph":
			set_mask(expected_mask)
			$AnimationPlayer.play("morph_back")
		"morph_back":
			busy = false
