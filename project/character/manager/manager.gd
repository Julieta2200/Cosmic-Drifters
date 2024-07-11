class_name Manager extends Waiter

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60

func check_queue():
	pass

func give_check_table(table: Table):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(serve_point, ready_give_check , table)

