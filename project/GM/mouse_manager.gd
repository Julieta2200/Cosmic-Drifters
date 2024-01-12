extends Node2D


func _on_game_manager_click_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$"..".character_start_movement()
			

func _on_game_manager_click_tarsier_area(viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$"..".selected_character = $"..".tarsier
