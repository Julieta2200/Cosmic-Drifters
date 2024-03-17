extends Node2D

@onready var player  = $"../player"
signal click_area_input_event(event)
var click_area : bool


func player_start_movement():
	player.start_movement()
	

func _on_walking_area_input_event(_viewport, event, _shape_idx):
	click_area_input_event.emit(event)
	
