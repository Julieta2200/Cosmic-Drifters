class_name Order extends Node

enum STATUS {PENDING, PREPARED, PICKED, DELIVERED}
var table: Table
var status: STATUS = STATUS.PENDING

func _init(t: Table):
	table = t
	

func _ready():
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	status = STATUS.PREPARED
	print("prepared")

func is_prepared():
	return status == STATUS.PREPARED
	
func is_picked():
	return status == STATUS.PICKED

func pick():
	status = STATUS.PICKED

func delivered():
	status = STATUS.DELIVERED
