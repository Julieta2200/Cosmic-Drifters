extends Node2D

var orders = []

func add_order(table):
	var order_timer = Timer.new()
	add_child(order_timer)
	order_timer.wait_time = 10.0
	order_timer.one_shot = true
	order_timer.start()
	order_timer.connect("timeout", _on_order_timer_timeout)

func _on_order_timer_timeout() -> void:
	queue_free()
