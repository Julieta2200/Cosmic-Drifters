class_name Enemy extends Character

func _ready():
	position_delta = speed / 60

func spawn(pos):
	global_position = pos
	
func _process(delta):
	move()

func order(node : Node2D, action: String):
	pass
	
