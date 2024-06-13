class_name Waiter extends Character

@export var waiter_manager: WaiterManager
var origin_position: Vector2
var busy: bool = false
var on_desk: bool = true

func _ready():
	origin_position = global_position
	position_delta = speed / 60
	
func _process(_delta):
	check_queue()
	move()

func check_queue():
	if busy:
		return
	
	if len(waiter_manager.queue) == 0:
		if !on_desk:
			on_desk = true
			walk_to(waiter_manager.level, origin_position, "")
		return
		
	busy = true
	on_desk = false
	var action = waiter_manager.queue[0]
	waiter_manager.queue.remove_at(0)
	match action["func"]:
		"walk_to":
			walk_to(waiter_manager.level, action["params"], action["action"])

func ask_order(table):
	table.call_orders(self)
