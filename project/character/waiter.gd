extends Character

func _ready():
	position_delta = speed / 60
	
func _process(delta):
	move()
