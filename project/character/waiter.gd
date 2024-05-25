extends Character

@export var lvl: Node2D
var busy: bool = false

func _ready():
	position_delta = speed / 60
	
func _process(delta):
	check_queue()
	move()

func check_queue():
	if busy:
		return
	
	if len(lvl.waiter_queue) == 0:
		return
		
	busy = true
	var action = lvl.waiter_queue[0]
	lvl.waiter_queue.remove_at(0)
	match action["func"]:
		"walk_to":
			walk_to(lvl, action["params"], action["action"])
