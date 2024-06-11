extends Node2D

const SPAWN_DELAY = 1
const ORDER_INTERVAL = 1

var enemies
var level
var group_obj
var table

var _spawn_index = 0
var spawn_timer

var _order_index = 0
var order_timer

func _ready():
	enemies = get_children()

func spawn(lvl, g_obj):
	level = lvl
	group_obj = g_obj
	level.door.play("open")
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = 4.0
	spawn_timer.one_shot = true
	spawn_timer.connect("timeout", _spawn)
	spawn_timer.start()

func _spawn():
	if _spawn_index == enemies.size():
		return
	var enemy = enemies[_spawn_index]
	enemy.spawn(level.spawn_point.global_position)
	var chair = group_obj["table"].get_chair(_spawn_index)
	enemy.walk_to(level, chair.global_position, group_obj["name"]+":"+str(_spawn_index)+":sit")
	_spawn_index += 1
	spawn_timer.wait_time = SPAWN_DELAY
	spawn_timer.start()

func order(t):
	table = t
	order_timer = Timer.new()
	add_child(order_timer)
	order_timer.wait_time = 0.1
	order_timer.one_shot = true
	order_timer.connect("timeout", _order)
	order_timer.start()

func _order():
	if _order_index == enemies.size():
		return
	var enemy = enemies[_order_index]
	var food = enemy.order(table, _order_index)
	table.add_order(food, _order_index)
	_order_index += 1
	order_timer.wait_time = ORDER_INTERVAL
	order_timer.start()

