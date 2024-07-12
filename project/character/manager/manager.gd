class_name Manager extends Waiter

signal walk_to_room

var serve_table
var room_position

func _physics_process(_delta):
	move()
	if serve_table != null:
		if serve_table.group.current_status == serve_table.group.STATUS_SERVE_END:
			busy = true
			walk_to(room_position, walk_to_room)
			serve_table = null
			

func _ready():
	position_delta = speed / 60
	room_position = $"../details/ManagerRoom".global_position

func check_queue():
	pass

func walk_to_give_check(table: Table):
	busy = true
	var serve_point = table.get_serve_point()
	walk_to(serve_point, ready_give_check , table)
	serve_table = table

func _on_walk_to_room():
	pass
