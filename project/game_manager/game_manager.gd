extends Node2D

@onready var player: Player  = $"../clickable_objects/player"
var click_area : bool
var selected_object = null
var locked: bool

func click_action():
	if locked:
		return
	
	if player.busy:
		return
	
	click_area = true
	var clicked_obj = $"../cursor_manager".detect_object()
	if clicked_obj is Area2D:
		player.walk_to(get_global_mouse_position(), player.any)
	elif clicked_obj is Table:
		player.interact_table(clicked_obj)
	elif clicked_obj is Computer:
		player.walk_to_computer(clicked_obj)
	elif clicked_obj is Desk:
		player.walk_to_desk(clicked_obj)
	elif clicked_obj is Player:
		player.open_characters_panel()
	elif clicked_obj.name == "manager_room":
		player.walk_to_manager()
	

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		click_action()
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
	

