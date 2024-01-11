extends Node2D

@onready var player: Player  = $"../player"
@onready var tarsier: Tarsier = $"../tarsier"
signal click_area_input_event(_viewport, event, _shape_idx)
signal click_tarsier(_viewport, event, _shape_idx)
var on_area_tarsier: bool 

func player_start_movement():
	player.start_movement()

func tarsier_start_movement():
	tarsier.start_movement()

func _on_walking_area_input_event(_viewport, event, _shape_idx):
	if on_area_tarsier:
		click_tarsier.emit(_viewport, event, _shape_idx)
		on_area_tarsier = false
	else:
		click_area_input_event.emit(_viewport, event, _shape_idx)


func _on_tarsier_click_tarsier_input_event(_viewport, _event, _shape_idx):
	on_area_tarsier = true
	
