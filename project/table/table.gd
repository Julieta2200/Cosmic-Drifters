extends Node2D

class_name Table

@onready var plate = $plate
var rng = RandomNumberGenerator.new()
const ORDER_INTERVAL: int = 1
var waiter
var level
var group
var for_lumina: bool = false
@onready var chairs = $chairs
@export var number: int
var eavesdropping_extent = 0
@export var suspect_time : float = 1
@export var cooldown_time : float = 1
var suspect_unit  = 10
var cooldown_unit = 10

enum {
	STATUS_EMPTY,
	STATUS_WAITING1,
	STATUS_WAITING_FOR_FOOD,
	STATUS_EATING_FOOD,
	STATUS_WAITING_FOR_CHECK
}
var status = STATUS_EMPTY

var table_status = "empty"

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

var enemies = {}
var actual_order = []
var plates_to_remove = []

func sit(enemy, chair_i, lvl, gr):
	level = lvl
	group = gr
	enemies[chair_i] = {"enemy": enemy}
	var chair = $chairs.get_children()[chair_i]
	enemy.global_position = chair.global_position
	chair.visible = false
	
func leave_chair(chair_i):
	var chair = $chairs.get_children()[chair_i]
	chair.visible = true
	return chair
	
func leave():
	status = STATUS_EMPTY
	group.group.leave()

func add_order(food, chair_i):
	enemies[chair_i]["order"] = food
	
func call_orders(w):
	waiter = w
	$status.pause_timer()
	group["group"].order(self)


func get_chair(index):
	return chairs.get_children()[index]
	
func get_serve_point():
	return $serve_point.global_position

func add_plates():
	for p in plate.get_children():
		p.texture = load(plates[rng.randf_range(0,plates.size())])
		p.visible = true
	
	var right_count = 0
		
	var found_indexes = {}
	for ac_ind in actual_order.size():
		found_indexes[ac_ind] = false
	for f in enemies:
		var food = enemies[f]["enemy"].get_food()
		var found = false
		for ac_ind in actual_order.size():
			if !found_indexes[ac_ind] && actual_order[ac_ind] == food:
				right_count+=1
				found_indexes[ac_ind] = true
				enemies[f]["enemy"].set_heart()
				plates_to_remove.append(f)
				found = true
				break
		if !found:
			enemies[f]["enemy"].set_angry()
	eating_food(right_count)
	
func remove_plates():
	for p in plate.get_children().size():
		if plates_to_remove.has(p):
			plate.get_children()[p].visible = false
	waiting_for_check()

func ordered(chair_i):
	if chair_i == len(chairs.get_children()) - 1:
		waiter.busy = false
		if !for_lumina:
			var a_orders = []
			for i in enemies:
				a_orders.append(enemies[i]["enemy"].get_food())
			set_actual_order(a_orders)
			waiter = null
			level.kitchen.add_order(self)
		else:
			level.computer.add_table(self)
		waiting_for_food()

func order_delivered():
	level.order_delivered(group)
	
func waiting_for_food():
	status = STATUS_WAITING_FOR_FOOD
	$status.waiting_for_food()
	
func eating_food(count):
	status = STATUS_EATING_FOOD
	$status.eating_food(count)
	
func waiting_for_check():
	status = STATUS_WAITING_FOR_CHECK
	$status.waiting_for_check()

func ask_waiter():
	status = STATUS_WAITING1
	$status.ask_waiter()
	
func action_complete(action, caller):
	match action:
		"ask_order":
			for_lumina = true
			call_orders(caller)
		"serve_food":
			caller.get_food(self)

func set_actual_order(foods):
	actual_order = foods
	waiter.busy = false
	level.computer.order_inserted(self)
	level.kitchen.add_order(self)


func _on_whisper_area_body_entered(body):
	if body is Player:
		$whisper_area/suspect_timer.start()
		$whisper_area/cooldown_timer.stop()

func _on_whisper_area_body_exited(body):
	if body is Player:
		$whisper_area/suspect_timer.stop()
		$whisper_area/cooldown_timer.start()
	
func _on_suspect_timer_timeout():
	if eavesdropping_extent < 100:
		eavesdropping_extent = eavesdropping_extent + suspect_unit
		print(eavesdropping_extent)
	else:
		$whisper_area/suspect_timer.stop()

func _on_cooldown_timer_timeout():
	if eavesdropping_extent > 0:
		eavesdropping_extent = eavesdropping_extent - cooldown_unit
		print(eavesdropping_extent)
	else:
		$whisper_area/cooldown_timer.stop()
