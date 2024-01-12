extends Node2D

@onready var player: Player  = $"../player"
@onready var tarsier: Tarsier = $"../tarsier"
signal click_area_input_event(viewport, event, _shape_idx)
signal click_tarsier_area(viewport, event, _shape_idx)
var selected_character : Character

#func player_start_movement():
#	player.start_movement()
#
#func tarsier_start_movement():
#	tarsier.start_movement()

func _ready():
	selected_character = player

func _on_walking_area_input_event(_viewport, event, _shape_idx):
	click_area_input_event.emit(_viewport, event, _shape_idx)
	

func _on_click_tarsier_input_event(viewport, event, _shape_idx):
	click_tarsier_area.emit(viewport, event, _shape_idx)
	print(viewport)
#	print($"../walking_area".get_overlapping_bodies ( ))

func character_start_movement():
	selected_character.start_movement()
	selected_character = player
	
