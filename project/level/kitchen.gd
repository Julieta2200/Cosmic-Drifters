extends Node2D

var orders = []
enum {PENDING, PREPARED, PICKED, DELIVERED}

@export var cooks: Array[Node2D]
@export var desk_point: Node2D

func _ready():
	for cook in cooks:
		cook.set_kitchen(self)

func add_order(table):
	var timer = get_tree().create_timer(5)
	orders.append({"table": table, "timer": timer, "status": PENDING, "cook": null})

func _process(_delta):
	for order in orders:
		if order["status"] == PENDING && order["timer"].time_left == 0.0:
			order_prepared(order)
	
	for order in orders:
		if order["status"] == PREPARED:
			for cook in cooks:
				if !cook.busy:
					cook.pick_order(order)
					break
			if order["status"] == PICKED:
				break

func order_prepared(order):
	order["status"] = PREPARED
	
func action_complete(order, cook):
	order["status"] = DELIVERED
	order["table"].order_delivered()
	cook.walk_to(cook, cook.origin_position, null)
