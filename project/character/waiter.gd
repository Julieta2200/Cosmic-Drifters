extends Character

class_name Waiter

@export var lvl: Node2D
@export var desk_point: Marker2D
var busy: bool = false
var on_desk: bool = true

func _ready():
	position_delta = speed / 60
	
func _process(delta):
	check_queue()
	move()

func check_queue():
	if busy:
		return
	
	if len(lvl.waiter_queue) == 0:
		if !on_desk:
			on_desk = true
			walk_to(lvl, desk_point.global_position, "")
		return
		
	busy = true
	on_desk = false
	var action = lvl.waiter_queue[0]
	lvl.waiter_queue.remove_at(0)
	match action["func"]:
		"walk_to":
			walk_to(lvl, action["params"], action["action"])

func ask_order(table):
	table.call_orders(self)
