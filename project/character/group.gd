extends Node2D

const SPAWN_DELAY = 1

var spawn_index = 0
var level
var group_obj
var timer
var enemies

func _ready():
	enemies = get_children()

func spawn(lvl, g_obj):
	level = lvl
	group_obj = g_obj
	level.door.play("open")
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 4.0
	timer.one_shot = true
	timer.connect("timeout", _spawn)
	timer.start()

func _spawn():
	if spawn_index == enemies.size():
		return
	var enemy = get_child(spawn_index)
	enemy.spawn(level.spawn_point.global_position)
	var chair = group_obj["table"].get_chair(spawn_index)
	enemy.walk_to(level, chair.global_position, group_obj["name"]+":"+str(spawn_index)+":sit")
	spawn_index += 1
	timer.wait_time = SPAWN_DELAY
	timer.start()
	
