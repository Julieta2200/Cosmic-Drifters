class_name Table extends Node2D

const ORDER_INTERVAL: int = 1

@onready var plate = $plate
@onready var chairs = $chairs
@onready var group_status: Status = $status

@export var number: int

@export var level: Level

var rng = RandomNumberGenerator.new()
var waiter: Waiter
var group: Group

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

var actual_order = []
var plates_to_remove = []


var food_action = false

func sit(chair_i):
	var chair = $chairs.get_children()[chair_i]
	chair.visible = false
	return chair
	
	
func leave_chair(chair_i):
	var chair = $chairs.get_children()[chair_i]
	chair.visible = true
	return chair

func reset():
	group = null
	
func leave():
	group.leave()
	
func call_orders(w):
	waiter = w
	group.order()


func get_chair(index):
	return chairs.get_children()[index]
	
func get_serve_point():
	return $serve_point.global_position

func add_plates():
	for p in plate.get_children():
		p.texture = load(plates[rng.randf_range(0,plates.size())])
		p.visible = true
	plates_to_remove = group.eating_food(actual_order)
	food_action = false
	
func remove_plates():
	for p in plate.get_children().size():
		if plates_to_remove.has(p):
			plate.get_children()[p].visible = false
	group.waiting_for_check()
	level.cafe_manager.ask_for_check(self)
	food_action = false

func ordered(a_orders):
	set_true_actual_order(a_orders)
	waiter.ordered(self)
	food_action = false

func serve_end():
	group.serve_end()


func set_actual_order(foods):
	actual_order = foods
	waiter.busy = false
	level.cafe_manager.add_order(self)

func set_true_actual_order(foods):
	actual_order = foods

func for_lumina() -> bool:
	if group == null:
		return false
	return group._for_lumina

func get_clickable_component():
	return $clickable_component

func get_approach_point() -> Marker2D:
	return $approach_point

func show_whisper_panel(show: bool):
	$whisper_area.visible = show
