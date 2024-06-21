class_name Table extends Node2D

const ORDER_INTERVAL: int = 1

@onready var plate = $plate
@onready var chairs = $chairs


@export var suspect_limit = 100
@export var suspect_time : float = 1
@export var cooldown_time : float = 1
@export var number: int

var rng = RandomNumberGenerator.new()
var waiter
var level
var group
var for_lumina: bool = false
var eavesdropping_extent = 0
var suspect_unit  = 10
var cooldown_unit = 10


var whisper_meter_sprites = {
	0: "res://assets/Game_UI/Scale/Scale1.png",
	1: "res://assets/Game_UI/Scale/Scale2.png",
	2: "res://assets/Game_UI/Scale/Scale3.png",
	3: "res://assets/Game_UI/Scale/Scale4.png",
	4: "res://assets/Game_UI/Scale/Scale5.png",
}

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

var whisper_step_time_init = 2
var whisper_step_time_suspect = 2
var whisper_step_time_cooldown = 2

var food_action = false
var player_in_whisper_area = false

func sit(enemy, chair_i, lvl, gr):
	level = lvl
	group = gr
	enemies[chair_i] = {"enemy": enemy}
	var chair = $chairs.get_children()[chair_i]
	enemy.global_position = chair.global_position
	chair.visible = false
	if whisper_step_time_init - enemy.whisper_coef < whisper_step_time_suspect:
		whisper_step_time_suspect = whisper_step_time_init - enemy.whisper_coef
		whisper_step_time_cooldown = whisper_step_time_init + enemy.whisper_coef
	$whisper_area/suspect_timer.wait_time = whisper_step_time_suspect
	$whisper_area/cooldown_timer.wait_time = whisper_step_time_cooldown
	
	
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
	set_status(STATUS_WAITING_FOR_FOOD)
	$status.waiting_for_food()
	
func eating_food(count):
	set_status(STATUS_EATING_FOOD)
	$status.eating_food(count)
	
func waiting_for_check():
	set_status(STATUS_WAITING_FOR_CHECK)
	$status.waiting_for_check()

func ask_waiter():
	set_status(STATUS_WAITING1)
	$status.ask_waiter()
	
func set_status(_status):
	status = _status
	food_action = false
	
func action_complete(action, caller):
	print(action)
	match action:
		"ask_order":
			food_action = true
			for_lumina = true
			call_orders(caller)
		"serve_food":
			food_action = true
			caller.get_food(self)

func set_actual_order(foods):
	actual_order = foods
	waiter.busy = false
	level.computer.order_inserted(self)
	level.kitchen.add_order(self)


func _on_whisper_area_body_entered(body):
	if body is Player:
		player_in_whisper_area = true

func _on_whisper_area_body_exited(body):
	if body is Player:
		player_in_whisper_area = false
	
func _on_suspect_timer_timeout():
	if eavesdropping_extent < suspect_limit - suspect_unit:
		eavesdropping_extent = eavesdropping_extent + suspect_unit
		set_whispere_meter()
	else:
		$whisper_area/suspect_timer.stop()

func _on_cooldown_timer_timeout():
	if eavesdropping_extent > 0:
		eavesdropping_extent = eavesdropping_extent - cooldown_unit
		set_whispere_meter()
	else:
		$whisper_area/cooldown_timer.stop()
		
func set_whispere_meter():
	$whisper_meter/sprite.texture = load(whisper_meter_sprites[int(eavesdropping_extent/20)])
		
func get_clickable_component():
	return $clickable_component
	
func _process(delta):
	if status == STATUS_EMPTY:
		$whisper_meter.visible = false
		return
	if food_action:
		$whisper_area/suspect_timer.stop()
		$whisper_area/cooldown_timer.stop()
		return
	if !player_in_whisper_area:
		$whisper_area/suspect_timer.stop()
		if $whisper_area/cooldown_timer.is_stopped():
			$whisper_area/cooldown_timer.start()
	else:
		$whisper_meter.visible = true
		if $whisper_area/suspect_timer.is_stopped():
			$whisper_area/suspect_timer.start()
		$whisper_area/cooldown_timer.stop()
