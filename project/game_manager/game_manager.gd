extends Node2D


@onready var player  = $"../clickable_objects/player"
signal click_area_input_event(event)
var click_area : bool
var selected_object 
var i = 0
var d


func start_movement():
	if Input.is_action_just_pressed("left_click"):
		if   $"../cursor_manager".detect_object() is Area2D:
			if i != 0:
				d.start_movement()
				i= i - 1
			else :
				player.start_movement()
		if $"../cursor_manager".detect_object() is Character:
			print($"../cursor_manager".detect_object())
			d=$"../cursor_manager".detect_object()
			i = i+1

					
			
			
			
		
#
func _process(delta):
	start_movement()
	

#func _on_walking_area_input_event(_viewport, event, _shape_idx):
#
##	selected_object = $"../cursor_manager".detect_object()
#	click_area_input_event.emit(event)
#if event is InputEventMouseButton and event.is_pressed():
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			$"..".start_movement()
#			$"..".click_area = true


#func _on_walking_area_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.is_pressed():
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			print(selected_object)
#			selected_object = $"../cursor_manager".detect_object()
#			start_movement()
