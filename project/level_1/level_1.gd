class_name Level1 extends Level

@export var computer: Node2D
@onready var kitchen = $kitchen
@onready var ui = $CanvasLayer/ui
@onready var spawn_point = $spawn_point
@onready var door = $details/door_animatedSprite2D

@onready var group_objs = {
	"group_1": {
		"group": $group_1,
		"table": $clickable_objects/Table,
		"name": "group_1",
		"spawn_time": 5,
		"for_lumina": false
	},
	"group_2": {
		"group": $group_2,
		"table": $clickable_objects/TableSmall,
		"name": "group_2",
		"spawn_time": 10,
		"for_lumina": false
	},
	"group_3": {
		"group": $group_3,
		"table": $clickable_objects/Table3,
		"name": "group_3",
		"spawn_time": 19,
		"for_lumina": true
	},
	"group_4": {
		"group": $group_4,
		"table": $clickable_objects/TableSmall2,
		"name": "group_4",
		"spawn_time": 26,
		"for_lumina": true
	},
	"group_5": {
		"group": $group_5,
		"table": $clickable_objects/Table2,
		"name": "group_5",
		"spawn_time": 33,
		"for_lumina": false
	}
}

func _ready():
	super._ready()
	for key in group_objs:
		group_objs[key]["group"].set_group_obj(group_objs[key])
		groups[key] = group_objs[key]["group"]
	
func action_complete(a: String, caller):
	var action := a.split(":")
	if len(action) < 3:
		return
	
	var group = groups[action[0]]
	var number = int(action[1])
	match action[2]:
		"ask_order":
			caller.ask_order(group._table)
		"pick_order":
			pick_order(group, caller)
		"serve_food":
			serve_food(group, caller)

func order_delivered(group):
	$clickable_objects/desk_plates.add_plate(group)
	if group._for_lumina:
		return
	else:
		waiter_queue.append({"func": "walk_to", "params": $order_desk.global_position, "action": group._name+"::pick_order"})

func serve_food(group, waiter):
	group._table.add_plates()
	waiter.busy = false
			
func pick_order(group, caller):
	$clickable_objects/desk_plates.remove_plate(group)
	var serve_point = group._table.get_serve_point()
	caller.walk_to(self, serve_point, group._name+"::serve_food")
	
func get_orders(group):
	var enemies= group.get_children()
	var i: int = 0
	for enemy in enemies:
		enemy.order(self, group._name+":"+str(i)+":order")
		group._orders.append(false)
		await get_tree().create_timer(ORDER_TIME).timeout
		i += 1


func _on_door_animated_sprite_2d_animation_finished():
	$details/door_animatedSprite2D.play("idle")
