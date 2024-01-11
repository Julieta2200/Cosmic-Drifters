extends Node2D

var on_click_tarsier : bool

func _on_game_manager_click_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if on_click_tarsier:
				$"..".tarsier_start_movement()
				on_click_tarsier = false
			else:
				$"..".player_start_movement()


func _on_game_manager_click_tarsier(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			on_click_tarsier = true
