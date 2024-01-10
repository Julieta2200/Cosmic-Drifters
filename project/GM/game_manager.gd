extends Node2D

@onready var player: Player  = $"../player"
@onready var tarsier: Tarsier = $"../tarsier"
signal click_area_input_event(_viewport, event, _shape_idx)
signal click_tarsier(_viewport, event, _shape_idx)
var t 

func player_start_movement():
	player.start_movement()

func tarsier_start_movement():
	tarsier.start_movement()

func _on_walking_area_input_event(_viewport, event, _shape_idx):
	if t:
		click_tarsier.emit(_viewport, event, _shape_idx)
		t = false
	else:
		click_area_input_event.emit(_viewport, event, _shape_idx)


func _on_tarsier_click_tarsier_input_event(_viewport, event, _shape_idx):
	t = true
	
