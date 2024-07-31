class_name WhisperManager extends Node2D

@onready var lumina = $"../clickable_objects/player"

func get_player() -> Player:
	return lumina
