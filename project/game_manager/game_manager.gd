extends Node2D


@onready var player  = $"../clickable_objects/player"
var click_area : bool
var selected_object = null
var table = null


func start_movement():
	click_area = true
#	if $"../cursor_manager".detect_object().chair_add.has(player):
	if $"../cursor_manager".detect_object() is Table:
		if $"../cursor_manager".detect_object().chair_add.size() != $"../cursor_manager".detect_object().chairs.get_children().size():
			if selected_object !=  null:
				selected_object.target_object = $"../cursor_manager".detect_object()
				selected_object.start_movement()
				selected_object = null
			else:
				player.target_object = $"../cursor_manager".detect_object()
				player.start_movement()
		
	if   $"../cursor_manager".detect_object() is Area2D:
		if selected_object !=  null:
			selected_object.start_movement()
			selected_object = null
		else :
			player.start_movement()
	if $"../cursor_manager".detect_object() is Character:
		selected_object = $"../cursor_manager".detect_object()

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		start_movement()
	

