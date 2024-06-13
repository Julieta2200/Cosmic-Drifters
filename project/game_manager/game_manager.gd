extends Node2D

@onready var player  = $"../clickable_objects/player"
var click_area : bool
var selected_object = null


func click_action():
	if player.busy:
		return
	
	click_area = true
	var clicked_obj = $"../cursor_manager".detect_object()
	if clicked_obj is Area2D:
		player.walk_to(null, get_global_mouse_position(), "")
	elif clicked_obj is Table:
		player.interact_table(clicked_obj)
	elif clicked_obj is Computer:
		player.input_order(clicked_obj)
	elif clicked_obj is Desk:
		player.pick_order(clicked_obj)
	elif clicked_obj is Player:
		player.open_characters_panel()
	

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		click_action()
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
	

