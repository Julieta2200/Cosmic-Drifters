class_name Player extends Waiter

var desk: Desk
var computer: Computer
var expected_mask
var previous_character
var recording: bool

signal ready_input_order
signal ready_choose_order
signal manager_room
signal recording_panel_open

var recorded_enemies: Array[Enemy]
var recorded_messages: Array
var current_recording: Array[String] = []
var recordings: Array[Dictionary] = []

@export var shapeshift_sprite : Texture
@export var ui: TopUI
@export var manager_room_position: Marker2D
@export var cafe_manager: CafeManager
@export var conversation_manager: ConversationManager
@export var recording_panel: Control

@onready var provider = $"../provider"


func check_queue():
	pass

func _process(delta):
	record_action()

func start_recording():
	if busy:
		recording = false
		return
		
	$whisper_panel.visible = recording
	recording_panel.visible = recording
	busy = true
	if recorded_enemies.size() > 0:
		var enemy = recorded_enemies[0]
		enemy.group.conversation.rend_dialog = true
		enemy.group._table.recorded = true

func stop_recording():
	recording = false
	$whisper_panel.visible = recording
	recording_panel.visible = recording
	conversation_manager.dialog.reset()
	busy = false
	if recorded_enemies.size() > 0:
		var enemy = recorded_enemies[0]
		enemy.group.conversation.rend_dialog = false
		enemy.group._table.recorded = false
	if current_recording.size() > 0:
		recordings.append({"group" : recorded_enemies[0].group ,"conversation" : current_recording})
		current_recording = []

func record_action():
	if Input.is_action_just_pressed("record"):
		recording = !recording
		if recording:
			start_recording()
		else:
			stop_recording()

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

func walk_to_manager():
	walk_to(manager_room_position.global_position, manager_room)

func walk_to_provider():
	busy = true
	var provider_approach_pos = provider.global_position - Vector2(-300,-300)
	walk_to(provider_approach_pos, recording_panel_open)

func open_characters_panel():
	busy = true
	$characters_panel.visible = true
	pass

func morph(mask = LUMINA):
	$characters_panel.visible = false
	expected_mask = mask

func set_mask(mask = LUMINA):
	current_mask = mask
	animation()
	
func record(text: String):
	current_recording.append(text)
	

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
	if character.texture != shapeshift_sprite:
		for i in $characters_panel.get_child_count():
			if i > 0 :
				if $characters_panel.get_child(i).get_child(0).texture == shapeshift_sprite:
					$characters_panel.get_child(i).get_child(0).texture = previous_character
					
		character.texture = shapeshift_sprite
		morph(_character_name)
		$AnimatedSprite2D.play(masks[_character_name] + "shapeshifting")
	else:
		morph(LUMINA)
		$AnimatedSprite2D.play("shapeshifting")
		character.texture = previous_character


func get_approach_points() -> Array[Node]:
	return $approach_points.get_children()

func get_save_point() -> Vector2:
	return $save_point.global_position

func _on_ready_input_order():
	input_order()

func _on_ready_choose_order():
	desk.open(self)


func _on_manager_room():
	if cafe_manager.manager.current_emotion == Emotions.alert:
		cafe_manager.manager.set_emotion(Emotions.angry)
		set_emotion(Emotions.sad)
	else:
		cafe_manager.manager.set_emotion(Emotions.question)
		set_emotion(Emotions.sad)

func make_free():
	busy = false
	


func _on_recording_area_body_entered(body):
	if body is Enemy:
		recorded_enemies.append(body)


func _on_recording_area_body_exited(body):
	if body is Enemy:
		var index: int = recorded_enemies.find(body)
		if index != -1:
			recorded_enemies.remove_at(index)
	

func _on_recording_panel_open():
	if recordings != []:
		cafe_manager.recording_panel.open(recordings)
	else:
		provider.start_talking()
