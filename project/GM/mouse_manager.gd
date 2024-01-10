extends Node2D

var t

func _on_game_manager_click_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if t :
				$"..".tarsier_start_movement()
				t = false
			else:
				$"..".player_start_movement()


func _on_game_manager_click_tarsier(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			t = true
