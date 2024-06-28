class_name Table extends Node2D

const ORDER_INTERVAL: int = 1

@onready var plate = $plate
@onready var chairs = $chairs
@onready var group_status = $status


@export var suspect_limit = 100
@export var suspect_time : float = 1
@export var cooldown_time : float = 1
@export var number: int

var rng = RandomNumberGenerator.new()
var waiter
@onready var level = $"../.."
var group
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

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

var actual_order = []
var plates_to_remove = []

var whisper_step_time_init = 2
var whisper_step_time_suspect = 2
var whisper_step_time_cooldown = 2

var food_action = false
var player_in_whisper_area = false

func sit(chair_i, whisper_coef):
	var chair = $chairs.get_children()[chair_i]
	chair.visible = false
	if whisper_step_time_init - whisper_coef < whisper_step_time_suspect:
		whisper_step_time_suspect = whisper_step_time_init - whisper_coef
		whisper_step_time_cooldown = whisper_step_time_init + whisper_coef
	$whisper_area/suspect_timer.wait_time = whisper_step_time_suspect
	$whisper_area/cooldown_timer.wait_time = whisper_step_time_cooldown
	return chair
	
	
func leave_chair(chair_i):
	var chair = $chairs.get_children()[chair_i]
	chair.visible = true
	return chair
	
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
	food_action = false

func ordered(a_orders):
	set_true_actual_order(a_orders)
	waiter.ordered(self)
	food_action = false

func order_delivered():
	level.order_delivered(group)
	
func action_complete(action, caller):
	match action:
		"ask_order":
			food_action = true
			call_orders(caller)
		"serve_food":
			food_action = true
			caller.get_food(self)
		"serve_check":
			food_action = true
			caller.get_check(self)
			group.serve_end()
			

func set_actual_order(foods):
	actual_order = foods
	waiter.busy = false
	level.computer.order_inserted(self)
	level.kitchen.add_order(self)

func set_true_actual_order(foods):
	actual_order = foods

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
	if group && group.group_current_status == group.STATUS_EMPTY:
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
