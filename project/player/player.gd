extends Character

class_name Player

var busy: bool = false

var items

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

func ask_order(table):
	if table.status != table.STATUS_WAITING1:
		return	
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(table, serve_point, "ask_order")

func input_order(computer):
	busy = true
	walk_to(computer, computer.use_point.global_position, "input_order")

func pick_order(desk):
	busy = true
	walk_to(desk, desk.use_point.global_position, "pick_order")

func pick_plates(table):
	print(table.group)
