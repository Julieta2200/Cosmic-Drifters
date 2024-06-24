extends Character

var kitchen
var origin_position
var busy: bool = false

func _ready():
	origin_position = global_position
	position_delta = speed / 60

func set_kitchen(k):
	kitchen = k

func _process(_delta):
	move()

func pick_order(order):
	busy = true
	order["status"] = kitchen.PICKED
	order["cook"] = self
	walk_to(kitchen, kitchen.desk_point.global_position, order)

func action_complete(_action, _caller):
	busy = false
