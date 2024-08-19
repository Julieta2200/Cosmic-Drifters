class_name Group extends Node2D

enum {
	STATUS_EMPTY,
	STATUS_ASKING_FOR_WAITER,
	STATUS_WAITING_FOR_FOOD,
	STATUS_EATING_FOOD,
	STATUS_WAITING_FOR_CHECK,
	STATUS_SERVE_END
}

@export var level: Level
@export var _spawn_time: float 
@export var _for_lumina: bool
@export var _table: Table
@export var conversation: Conversation

@onready var _enemies_cont = $enemies

var table_status

var current_status = STATUS_EMPTY

var enemies: Array[Enemy]

const SPAWN_DELAY = 1
const ORDER_INTERVAL = 1

var _spawn_index = 0
var _timer

var _order_index = 0

signal ready_sit(index: int)
signal ready_exit(index: int)

func _ready():
	for enemy in _enemies_cont.get_children():
		enemies.append(enemy as Enemy)
	_table.group = self
	table_status = _table.group_status
	_create_timer(_spawn_time, true, _spawn)

func _spawn():
	if _spawn_index == 0:
		level.door.play("open")
	if _spawn_index == enemies.size():
		_spawn_index = 0
		return
	var enemy = enemies[_spawn_index]
	enemy.spawn(level.spawn_point.global_position)
	var chair = _table.get_chair(_spawn_index)
	enemy.walk_to(chair.global_position, ready_sit, _spawn_index)
	_spawn_index += 1
	_timer.wait_time = SPAWN_DELAY
	_timer.start()

func _create_timer(time, one_shot, timeout_callback):
	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = time
	_timer.one_shot = one_shot
	_timer.connect("timeout", timeout_callback)
	_timer.start()

func leave():
	_create_timer(1.0, true, _leave)
	
func _leave():
	current_status = STATUS_EMPTY
	if _spawn_index == enemies.size():
		_spawn_index = 0
		return
	var enemy: Enemy = enemies[_spawn_index]
	var chair = _table.leave_chair(_spawn_index)
	enemy.spawn(chair.global_position)
	enemy.walk_to(level.door.global_position, ready_exit, _spawn_index)
	_spawn_index += 1
	_timer.wait_time = SPAWN_DELAY
	_timer.start()

func order():
	_create_timer(0.1, true, _order)

func _order():
	if _order_index == enemies.size():
		start_talking()
		return
	var enemy = enemies[_order_index]
	enemy.order(_order_index)
	_order_index += 1
	_timer.wait_time = ORDER_INTERVAL
	_timer.start()

func start_talking():
	if conversation != null:
		conversation.start()

func _ask_for_waiter():
	if _for_lumina:
		current_status = STATUS_ASKING_FOR_WAITER
		table_status.ask_waiter()
		return
	level.cafe_manager.ask_waiters(self)
	

func ordered(enemy_i):
	table_status.timer_delete()
	if enemy_i == len(enemies) - 1:
		_table.ordered(get_orders())
		waiting_for_food()
		
func waiting_for_food():
	current_status = STATUS_WAITING_FOR_FOOD
	table_status.waiting_for_food()
	
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
	current_status = STATUS_EATING_FOOD
	table_status.eating_food(right_count)
	return plates_to_remove

func waiting_for_check():
	current_status = STATUS_WAITING_FOR_CHECK
	table_status.waiting_for_check()
	
func serve_end():
	current_status = STATUS_SERVE_END
	table_status.serve_end()

func get_orders():
	var orders = []
	for ei in enemies.size():
		orders.append(enemies[ei].get_food())
	return orders

func _on_ready_sit(index: int):
	var chair = _table.sit(index)
	enemies[index].global_position = chair.global_position
	if index == len(enemies) - 1:
		_ask_for_waiter()

func get_table() -> Table:
	return _table

func _on_ready_exit(index):
	enemies[index].spawn(Vector2(0,0))
	if index == enemies.size() - 1:
		_table.reset()
		

func _walk_to_door():
	current_status = STATUS_EMPTY
	if _spawn_index == enemies.size():
		_spawn_index = 0
		return
	var enemy: Enemy = enemies[_spawn_index]
	enemy.walk_to(level.door.global_position, ready_exit, _spawn_index)
	_spawn_index += 1
	_timer.wait_time = SPAWN_DELAY
	_timer.start()

func walk_to_door():
	_create_timer(0.5, true, _walk_to_door)

func get_enemy(i: int) -> Enemy:
	return enemies[i]
