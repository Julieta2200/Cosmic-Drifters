extends Node2D


func _on_game_manager_click_area_input_event(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			$"..".player_start_movement()
