extends Character 
class_name Security_guard

func _ready():
	position_delta = speed / 60
	
func _process(_delta):
	move()
