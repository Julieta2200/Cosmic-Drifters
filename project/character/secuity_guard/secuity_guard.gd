class_name Oliver extends Character

func _ready():
	position_delta = speed / 60

func _physics_process(_delta):
	move()
