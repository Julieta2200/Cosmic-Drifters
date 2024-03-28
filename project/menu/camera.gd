extends Camera2D

@export var speed: int

func _process(delta):
	var pos = Vector2(speed * delta, 0);
	position += pos;
