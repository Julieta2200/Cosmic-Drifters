class_name Kitchen extends Node2D

var orders: Array[Order] = []

@export var cooks: Array[Cook]
@export var desk_point: Node2D

@onready var cafe_manager: CafeManager = $"../cafe_manager"

func _ready():
	for cook in cooks:
		cook.set_kitchen(self)

func add_order(table: Table):
	var order: Order = Order.new(table)
	add_child(order)
	orders.append(order)

func _process(_delta):
	for order in orders:
		if order.is_prepared():
			for cook in cooks:
				if !cook.busy:
					cook.pick_order(order)
					break
			if order.is_picked():
				break
	
func order_delivered(order: Order):
	order.delivered()
	cafe_manager.order_ready(order.table)


func _on_area_2d_body_entered(body):
	if body is Player:
		$Cook.play("angry")


func _on_area_2d_body_exited(body):
	if body is Player:
		$Cook.play("default")
