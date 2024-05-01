class_name Enemy extends Character

func spawn(pos):
	global_position = pos
	
func _process(delta):
	move()
