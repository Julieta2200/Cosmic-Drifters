extends Node2D

@onready var player  = $"../clickable_objects/player"
var click_area : bool
var selected_object = null


func start_movement():
	click_area = true
	var clicked_obj = $"../cursor_manager".detect_object()
	if clicked_obj is Area2D:
		player.start_movement(get_global_mouse_position())
	elif clicked_obj is Table:
		var serve_point = clicked_obj.get_serve_point()
		var group = clicked_obj.group
		player.walk_to($"..", serve_point, "lumina:"+group["name"]+"::ask_order")

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		start_movement()
	

