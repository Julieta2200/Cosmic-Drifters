extends Character

class_name Tarsier

signal click_tarsier_input_event(_viewport, event, _shape_idx)

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

func _on_click_tarsier_area_input_event(viewport, event, shape_idx):
	click_tarsier_input_event.emit(viewport, event, shape_idx)


