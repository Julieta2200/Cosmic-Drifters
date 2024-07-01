extends Node2D

var _spawn_time = 0
var _for_lumina
var _table
var _served = false
var _name
var _orders = []

@onready var _enemies_cont = $enemies
var _status

enum {
	STATUS_EMPTY,
	STATUS_ASKING_FOR_WAITER,
	STATUS_WAITING_FOR_FOOD,
	STATUS_EATING_FOOD,
	STATUS_WAITING_FOR_CHECK,
	STATUS_SERVE_END
}
var group_current_status = STATUS_EMPTY

var enemies

const SPAWN_DELAY = 1
const ORDER_INTERVAL = 1

@onready var level = $".."

var _spawn_index = 0
var _timer

var _order_index = 0

func _ready():
	enemies = _enemies_cont.get_children()
	
func _create_timer(time, one_shot, timeout_callback):
	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = time
	_timer.one_shot = one_shot
	_timer.connect("timeout", timeout_callback)
	_timer.start()
	
func set_group_obj(_group_obj):
	_spawn_time = _group_obj["spawn_time"]
	_for_lumina = _group_obj["for_lumina"]
	_table = _group_obj["table"]
	_table.group = self
	_status = _table.group_status
	_name = _group_obj["name"]
	_create_timer(_group_obj["spawn_time"], true, _spawn)
	
func leave():
	group_current_status = STATUS_EMPTY
	_create_timer(1.0, true, _leave)
	
func _leave():
	if _spawn_index == enemies.size():
		_spawn_index = 0
		return
	var enemy = enemies[_spawn_index]
	var chair = _table.leave_chair(_spawn_index)
	enemy.spawn(chair.global_position)
	enemy.walk_to(self, level.door.global_position, _name+":"+str(_spawn_index)+":leave")
	_spawn_index += 1
	_timer.wait_time = SPAWN_DELAY
	_timer.start()

func _spawn():
	if _spawn_index == 0:
		level.door.play("open")
	if _spawn_index == enemies.size():
		_spawn_index = 0
		return
	var enemy = enemies[_spawn_index]
	enemy.spawn(level.spawn_point.global_position)
	var chair = _table.get_chair(_spawn_index)
	enemy.walk_to(self, chair.global_position, _name+":"+str(_spawn_index)+":sit")
	_spawn_index += 1
	_timer.wait_time = SPAWN_DELAY
	_timer.start()

func order():
	_create_timer(0.1, true, _order)

func _order():
	if _order_index == enemies.size():
		return
	var enemy = enemies[_order_index]
	var food = enemy.order(_order_index)
	_order_index += 1
	_timer.wait_time = ORDER_INTERVAL
	_timer.start()
	

func action_complete(a: String, caller):
	var action := a.split(":")
	if len(action) < 3:
		return
	
	var number = int(action[1])
	match action[2]:
		"sit":
			var chair = _table.sit(number, caller.whisper_coef)
			caller.global_position = chair.global_position
			if number == len(enemies) - 1:
				serve()
		"leave":
			enemies[number].spawn(Vector2(-1000, -1000))


func serve():
	if _for_lumina:
		group_current_status = STATUS_ASKING_FOR_WAITER
		_status.ask_waiter()
		return
	if _served:
		return
	_served = true
	var serve_point = _table.get_serve_point()
	level.waiter_queue.append({"func": "walk_to", "params": serve_point, "action": _name+"::ask_order"})

func ordered(enemy_i):
	_status.pause_timer()
	if enemy_i == len(enemies) - 1:
		_table.ordered(get_orders())
		waiting_for_food()
		
func waiting_for_food():
	group_current_status = STATUS_WAITING_FOR_FOOD
	_status.waiting_for_food()
	
func eating_food(actual_order):
	var right_count = 0
	
	var plates_to_remove = []
		
	var found_indexes = {}
	for ac_ind in actual_order.size():
		found_indexes[ac_ind] = false
	for f in enemies.size():
		var food = enemies[f].get_food()
		var found = false
		for ac_ind in actual_order.size():
			if !found_indexes[ac_ind] && actual_order[ac_ind] == food:
				right_count+=1
				found_indexes[ac_ind] = true
				enemies[f].set_heart()
				plates_to_remove.append(f)
				found = true
				break
		if !found:
			enemies[f].set_angry()
	group_current_status = STATUS_EATING_FOOD
	_status.eating_food(right_count)
	return plates_to_remove

func waiting_for_check():
	group_current_status = STATUS_WAITING_FOR_CHECK
	_status.waiting_for_check()
	
func serve_end():
	group_current_status = STATUS_SERVE_END
	_status.serve_end()

func get_orders():
	var orders = []
	for ei in enemies.size():
		orders.append(enemies[ei].get_food())
	return orders
