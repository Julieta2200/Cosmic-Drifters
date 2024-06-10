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

func sit(enemy, chair_i, lvl, gr):
	level = lvl
	group = gr
	enemies[chair_i] = {"enemy": enemy}
	var chair = $chairs.get_children()[chair_i]
	enemy.global_position = chair.global_position
	chair.visible = false

func add_order(food, chair_i):
	enemies[chair_i]["order"] = food
	
func call_orders(w):
	waiter = w
	call_deferred("_call_orders")
		
func _call_orders():
	for i in enemies:
		var food = enemies[i]["enemy"].order(self, i)
		add_order(food, i)
		await get_tree().create_timer(ORDER_INTERVAL).timeout

func get_chair(index):
	return chairs.get_children()[index]
	
func get_serve_point():
	return $serve_point.global_position

func add_plates():
	for p in plate.get_children():
		p.texture = load(plates[rng.randf_range(0,plates.size())])
		p.visible = true
	eating_food()
	
func remove_plates():
	for p in plate.get_children():
		p.visible = false
	waiting_for_check()

func ordered(chair_i):
	if chair_i == len(chairs.get_children()) - 1:
		waiter.busy = false
		if !for_lumina:
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
	
func eating_food():
	status = STATUS_EATING_FOOD
	$status.set_table(self)
	$status.eating_food()
	
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
