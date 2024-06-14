class_name Level extends Node2D

const SPAWN_DELAY = 1
const ORDER_TIME: int = 1

var level_time: int = 500
@export var computer: Node2D
@onready var kitchen = $kitchen
@onready var ui = $CanvasLayer/ui
@onready var spawn_point = $spawn_point
@onready var door = $details/door_animatedSprite2D

@onready var group_1 = {
	"group": $group_1,
	"table": $clickable_objects/Table,
	"name": "group_1",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 5,
	"for_lumina": true
}

@onready var group_2 = {
	"group": $group_2,
	"table": $clickable_objects/TableSmall,
	"name": "group_2",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 10,
	"for_lumina": true
}

@onready var group_3 = {
	"group": $group_3,
	"table": $clickable_objects/Table3,
	"name": "group_3",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 19,
	"for_lumina": true
}

@onready var group_4 = {
	"group": $group_4,
	"table": $clickable_objects/TableSmall2,
	"name": "group_4",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 26,
	"for_lumina": true
}

@onready var group_5 = {
	"group": $group_5,
	"table": $clickable_objects/Table2,
	"name": "group_5",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 33
}

@onready var groups = {
	"group_1": group_1,
	"group_2": group_2,
	"group_3": group_3,
	"group_4": group_4,
	"group_5": group_5,
}

var waiter_queue = []

func _ready():
	$Timer.wait_time = level_time
	$Timer.start()

func _process(_delta):
	for k in groups:
		if is_spawn_time(groups[k]):
			spawn(groups[k])

func is_spawn_time(group) -> bool:
	return round($Timer.time_left) == level_time - group["spawn_time"] && !group["spawned"]


func spawn(group):
	group["spawned"] = true
	group["group"].spawn(self, group)
		
func serve(group):
	if group.has("for_lumina"):
		group["table"].ask_waiter()
		return
	if group["served"]:
		return
	group["served"] = true
	var serve_point = group["table"].get_serve_point()
	waiter_queue.append({"func": "walk_to", "params": serve_point, "action": group["name"]+"::ask_order"})
	
func action_complete(a: String, caller):
	var action := a.split(":")
	if len(action) < 3:
		return
	
	var group = groups[action[0]]
	var enemies = group["group"].enemies
	var number = int(action[1])
	match action[2]:
		"sit":
			group["table"].sit(caller, number, self, group)
			if number == len(enemies) - 1:
				serve(group)
		"ask_order":
			caller.ask_order(group["table"])
		"pick_order":
			pick_order(group, caller)
		"serve_food":
			serve_food(group, caller)
		"leave":
			enemies[number].spawn(Vector2(-1000, -1000))

func order_delivered(group):
	$clickable_objects/desk_plates.add_plate(group)
	if group.has("for_lumina"):
		return
	else:
		waiter_queue.append({"func": "walk_to", "params": $order_desk.global_position, "action": group["name"]+"::pick_order"})

func call_lumina(group):
	group["table"].call_lumina()

func serve_food(group, waiter):
	group["table"].add_plates()
	waiter.busy = false
			
func pick_order(group, caller):
	$clickable_objects/desk_plates.remove_plate(group)
	var serve_point = group["table"].get_serve_point()
	caller.walk_to(self, serve_point, group["name"]+"::serve_food")
	
func get_orders(group):
	var enemies= group["group"].get_children()
	var i: int = 0
	for enemy in enemies:
		enemy.order(self, group["name"]+":"+str(i)+":order")
		group["orders"].append(false)
		await get_tree().create_timer(ORDER_TIME).timeout
		i += 1


func _on_door_animated_sprite_2d_animation_finished():
	$details/door_animatedSprite2D.play("idle")
