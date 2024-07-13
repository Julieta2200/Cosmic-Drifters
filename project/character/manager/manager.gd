class_name Manager extends Waiter

var serve_table
var room_position

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60
	room_position = $"../details/ManagerRoom".global_position

func check_queue():
	pass

func walk_to_give_check(table: Table):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(serve_point, ready_give_check , table)

func walk_to_room():
	busy = true
	walk_to(room_position, any)

func _on_ready_give_check(table: Table):
	super._on_ready_give_check(table)
	walk_to_room()
	
