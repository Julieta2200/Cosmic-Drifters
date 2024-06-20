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
@onready var left_click: Sprite2D = $CanvasLayer/tutorial_assets/left_click

const _first_customers_cam_pos: Vector2 = Vector2(3230, 2044)

var _timer: Timer

func _ready():
	camera.locked = true
	game_manager.locked = true
	groups = {}

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		if table_cursor.visible:
			if groups["group_1"]["table"].get_clickable_component().active:
				_table_clicked()

func intro_dialog():
	text_dialog.appear("Agent Lumina, can you hear me?","????", boss.character_sprite)
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
	text_dialog.appear("My code name is Nebula, want to know my real name?", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _name_reveal, _lumina_dialog_rendered2)

func _lumina_dialog_rendered2():
	text_dialog.appear("...", player.character_name, player.character_sprite)
	_reset_timer(1.0, _lumina_dialog_rendered2, _start_instructions)

func _start_instructions():
	text_dialog.appear("You seem like a very talkative person, anyways let’s start with your instructions, shall we?", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _start_instructions, _greetings)

func _greetings():
	text_dialog.appear("Welcome to Cosmic Whispers cafe!!!", boss.character_name, boss.character_sprite)
	_reset_timer(3.0, _greetings, _objective)

func _objective():
	text_dialog.appear("Your main objective is to get intel from some visitors who are connected with intergalactic crime organizations.", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _objective, _warning)

func _warning():
	text_dialog.appear("Cafes manager Frostwirl has no idea that you’re an agent, so you should be careful to not to get fired.", boss.character_name, boss.character_sprite)
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
	groups["group_1"] = {
		"group": $group_1,
		"table": $clickable_objects/Table,
		"name": "group_1",
		"orders": [],
		"served": false,
		"spawned": false,
		"spawn_time": 5,
		"for_lumina": true
	}
	spawn(groups["group_1"])
	_reset_timer(7.0, _first_customers, _table_status_instructions)
	
func _table_status_instructions():
	table_statuses.visible = true
	text_dialog.appear("Table statuses", boss.character_name, boss.character_sprite)
	_reset_timer(4.0, _table_status_instructions, _click_table)
	
func _click_table():
	table_statuses.visible = false
	table_cursor.visible = true
	game_manager.locked = false
	camera.locked = false
	text_dialog.appear("Click table", boss.character_name, boss.character_sprite)
	
func _table_clicked():
	table_cursor.visible = false
