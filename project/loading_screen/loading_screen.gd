extends Node2D

signal loading_screen_has_full_coverage

func _ready():
	emit_signal("loading_screen_has_full_coverage")
	
func _start_outro_animation() -> void:
	self.queue_free()

