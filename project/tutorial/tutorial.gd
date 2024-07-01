class_name Tutorial extends Level

var tutorial_mode: bool = false
@onready var text_dialog: Dialog = $CanvasLayer/dialog
@onready var boss: Boss = $boss
@onready var player: Player = $clickable_objects/player
@onready var arrows: TextureRect = $CanvasLayer/tutorial_assets/arrows
@onready var camera: Camera2D = $clickable_objects/player/Camera2D
@onready var game_manager = $game_manager
@onready var table_statuses: Control = $CanvasLayer/tutorial_assets/table_statuses
@onready var table_cursor: Sprite2D = $clickable_objects/Table/cursor
@onready var left_click: TextureRect = $CanvasLayer/tutorial_assets/left_click
@onready var door = $details/door_animatedSprite2D
@onready var spawn_point = $spawn_point
@onready var computer = $clickable_objects/computer
@onready var kitchen = $kitchen

const _first_customers_cam_pos: Vector2 = Vector2(3230, 2044)
const _waiter_approaches_cam_pos: Vector2 = Vector2(6536, 1327)
const _kitchen_cam_pos: Vector2 = Vector2(10242, 4510)

var _timer: Timer

func _ready():
	camera.locked = true
	game_manager.locked = true
	groups = {}

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
#		if table_cursor.visible:
#			if groups["group_1"]._table.get_clickable_component().active:
#				_table_clicked()
		var clicked_obj = $cursor_manager.detect_object()
		if clicked_obj is Table:
			_table_clicked()
			_reset_timer(7.0, _click_table , _click_computer)
		elif clicked_obj is Computer:
			_table_clicked()
			_reset_timer(2.0,_click_computer, _selected_food)
		

func intro_dialog():
	text_dialog.appear("Agent (Lumina), can you hear me?","????", boss.character_sprite)
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_reset_timer(3.0, _intro_dialog_rendered, _intro_dialog_rendered, false)
	
func _reset_timer(time: float, prev: Callable, next: Callable, has_prev: bool = true):
#	time = 0.5 #for fast test
	if has_prev:
		_timer.disconnect("timeout", prev)
	_timer.wait_time = time
	_timer.connect("timeout", next)
	_timer.start()

func _intro_dialog_rendered():
	text_dialog.appear("...", player.character_name, player.character_sprite)
	_reset_timer(1.0, _intro_dialog_rendered, _lumina_dialog_rendered1)

func _lumina_dialog_rendered1():
	text_dialog.appear("I’m the agent who’s assigned to help you with the undercover mission.", "????", boss.character_sprite)
	_reset_timer(4.0, _lumina_dialog_rendered1, _name_reveal)

func _name_reveal():
	text_dialog.appear("My code name is (Nebula), want to know my real name?", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _name_reveal, _lumina_dialog_rendered2)

func _lumina_dialog_rendered2():
	text_dialog.appear("...", player.character_name, player.character_sprite)
	_reset_timer(1.0, _lumina_dialog_rendered2, _start_instructions)

func _start_instructions():
	text_dialog.appear("You seem like a very talkative person, anyways let’s start with your instructions, shall we?", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _start_instructions, _greetings)

func _greetings():
	text_dialog.appear("Welcome to (COSMIC WHISPERS) cafe!!!", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _greetings, _objective)

func _objective():
	text_dialog.appear("Your main objective is to get intel from some visitors who are connected with intergalactic crime organizations.", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _objective, _warning)

func _warning():
	text_dialog.appear("Cafes manager (Frostwirl) has no idea that you’re an agent, so you should be careful to not to get fired.", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _warning, _use_arrows)

func _use_arrows():
	arrows.visible = true
	camera.locked = false
	text_dialog.appear("Use arrows to look around the cafe", boss.character_name, boss.character_sprite)
	_reset_timer(8.0, _use_arrows, _use_left_click)

func _use_left_click():
	arrows.visible = false
	left_click.visible = true
	game_manager.locked = false
	text_dialog.appear("Press left mouse button to walk around", boss.character_name, boss.character_sprite)
	_reset_timer(8.0, _use_left_click, _first_customers)

func _first_customers():
	left_click.visible = false
	camera.locked = true
	game_manager.locked = true
	camera.global_position = _first_customers_cam_pos
	text_dialog.appear("First customers", boss.character_name, boss.character_sprite)
	var group = $group_1
	group.set_group_obj({
		"group": $group_1,
		"table": $clickable_objects/Table,
		"name": "group_1",
		"for_lumina": true,
		"spawn_time": 5,
	})
	groups["group_1"] = group
	_reset_timer(9.0, _first_customers, _waiter_approaches)
	
func _waiter_approaches():
	camera.global_position = _waiter_approaches_cam_pos
	text_dialog.appear("Waiter approaches", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _waiter_approaches, _waiter_takes_orders)

func _waiter_takes_orders():
	camera.global_position = _first_customers_cam_pos
	text_dialog.appear("You should remember", boss.character_name, boss.character_sprite)
	_reset_timer(7.0, _waiter_takes_orders, _cooking_process)

func _cooking_process():
	camera.position = Vector2.ZERO
	text_dialog.appear("Explaining cooking", boss.character_name, boss.character_sprite)
	_reset_timer(5.0, _cooking_process, _show_kitchen)

func _show_kitchen():
	camera.global_position = _kitchen_cam_pos
	text_dialog.appear("Bob is making something", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _show_kitchen, _cook_1_brings_food)

func _cook_1_brings_food():
	camera.position = Vector2.ZERO
	text_dialog.appear("Food put on a desk", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _cook_1_brings_food, _waiter_serves_food)
	
func _waiter_serves_food():
	camera.global_position = _first_customers_cam_pos
	text_dialog.appear("Food served", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _waiter_serves_food , _coming_customers)

func _coming_customers():
	camera.global_position = door.position
	text_dialog.appear("The guests arrived", boss.character_name, boss.character_sprite)
	var group = $group_3
	group.set_group_obj({
		"group": $group_3,
		"table": $clickable_objects/Table2,
		"name": "group_3",
		"for_lumina": true,
		"spawn_time": 2,
	})
	await get_tree().create_timer(4).timeout
	camera.global_position = group._table.global_position
	groups["group_3"] = group
	_reset_timer(6.0, _coming_customers, _table_status_instructions)
	
func _table_status_instructions():
	table_statuses.visible = true
	text_dialog.appear("Explanation of statuses", boss.character_name, boss.character_sprite)
	_reset_timer(7.0, _table_status_instructions, _click_table)

func _click_table():
	camera.locked = false
	game_manager.locked = false
	table_statuses.visible = false
	table_cursor.position = Vector2(140,-18)
	table_cursor.visible = true
	text_dialog.appear("Click on the table to pick up the order", boss.character_name, boss.character_sprite)
	
func _click_computer():
	table_cursor.position = Vector2(330,-110)
	table_cursor.visible = true
	camera.global_position = computer.global_position
	text_dialog.appear("Click on the computer to select the order", boss.character_name, boss.character_sprite)

func _selected_food():
	text_dialog.appear("Selected food", boss.character_name, boss.character_sprite)
	await get_tree().create_timer(2).timeout
	$CanvasLayer/dialog.disappear()

func _table_clicked():
	table_cursor.visible = false
