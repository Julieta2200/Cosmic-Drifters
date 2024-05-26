extends Level

const SPAWN_DELAY = 1
const ORDER_TIME: int = 1

var level_time: int = 500

@onready var group_1 = {
	"group": $group_1,
	"table": $clickable_objects/Table,
	"name": "group_1",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 5
}

@onready var group_2 = {
	"group": $group_2,
	"table": $clickable_objects/TableSmall,
	"name": "group_2",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 10
}

@onready var group_3 = {
	"group": $group_3,
	"table": $clickable_objects/Table3,
	"name": "group_3",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 18
}

@onready var group_4 = {
	"group": $group_4,
	"table": $clickable_objects/TableSmall2,
	"name": "group_4",
	"orders": [],
	"served": false,
	"spawned": false,
	"spawn_time": 26
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

func _process(delta):
	for k in groups:
		if is_spawn_time(groups[k]):
			spawn(groups[k])

func is_spawn_time(group) -> bool:
	return round($Timer.time_left) == level_time - group["spawn_time"] && !group["spawned"]


func spawn(group):
	group["spawned"] = true
	call_deferred("spawn_and_sit", group)

func spawn_and_sit(group):
	var enemies= group["group"].get_children()
	var i: int = 0
	for enemy in enemies:
		enemy.spawn($spawn_point.global_position)
		var chair = group["table"].get_chair(i)
		enemy.walk_to(self, chair.global_position, group["name"]+":"+str(i)+":sit")
		i += 1
		await get_tree().create_timer(SPAWN_DELAY).timeout
		
func serve(group):
	if group["served"]:
		return
	group["served"] = true
	var serve_point = group["table"].get_serve_point()
	waiter_queue.append({"func": "walk_to", "params": serve_point, "action": group["name"]+"::ask_order"})
	
func action_complete(a: String, caller):
	var action := a.split(":")
	if len(action) < 3:
		return
	
	match action[2]:
		"sit":
			groups[action[0]]["table"].sit_down(int(action[1]))
			serve(groups[action[0]])
		"ask_order":
			ask_order(groups[action[0]], caller)
		"order":
			if len(action) == 3:
				waiter_to_desk(groups[action[0]], int(action[1]))
			else:
				match action[3]:
					"order_prepared":
						order_prepared(groups[action[0]], int(action[1]))
		"pick_order":
			pick_order(groups[action[0]], caller)
		"serve_food":
			serve_food(groups[action[0]], caller)

func serve_food(group, waiter):
	group["table"].add_plates()
	waiter.busy = false
			
func pick_order(group, caller):
	$desk_plates.remove_plate()
	var serve_point = group["table"].get_serve_point()
	caller.walk_to(self, serve_point, group["name"]+"::serve_food")

func ask_order(group, waiter):
	group["waiter"] = waiter
	call_deferred("get_orders", group)
	
func get_orders(group):
	var enemies= group["group"].get_children()
	var i: int = 0
	for enemy in enemies:
		enemy.order(self, group["name"]+":"+str(i)+":order")
		group["orders"].append(false)
		await get_tree().create_timer(ORDER_TIME).timeout
		i += 1

func waiter_to_desk(group, num):
	if num != len(group["group"].get_children()) - 1:
		return
	group["waiter"].busy = false
	
func order_prepared(group, num):
	group["orders"][num] = true
	for order in group["orders"]:
		if !order:
			return # pending order
	# order done
	$desk_plates.add_plate()
	waiter_queue.append({"func": "walk_to", "params": $order_desk.global_position, "action": group["name"]+"::pick_order"})

	
