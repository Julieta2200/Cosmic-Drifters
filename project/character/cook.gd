class_name Cook extends Character

var kitchen: Kitchen
var origin_position
var busy: bool = false

signal order_delivered(order)
signal returned_to_origin

func _ready():
	origin_position = global_position
	position_delta = speed / 60

func set_kitchen(k: Kitchen):
	kitchen = k

func _process(_delta):
	move()

func pick_order(order: Order):
	busy = true
	order.pick()
	walk_to(kitchen.desk_point.global_position, order_delivered, order)

func _on_order_delivered(order: Order):
	kitchen.order_delivered(order)
	walk_to(origin_position, returned_to_origin)


func _on_returned_to_origin():
	busy = false
