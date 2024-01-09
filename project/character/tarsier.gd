extends Character

class_name Tarsier

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()
