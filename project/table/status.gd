class_name Status extends Node2D

@onready var stages = {
	$ask_waiter: {
		1: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Green).png", "duration": 10},
		2: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Orange).png", "duration": 10},
		3: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Red).png", "duration": 10},
		4: {"texture": "res://assets/Emotions/Exclamation_mark/ExclamationMark(Fier1).png", "duration": 10}
	},
	$waiting_for_food: {
		1: {"texture": "res://assets/Emotions/Wait-for-food/wait-for-food1.png", "duration": 15},
		2: {"texture": "res://assets/Emotions/Wait-for-food/wait-for-food2.png", "duration": 15},
		3: {"texture": "res://assets/Emotions/Wait-for-food/wait-for-food3.png", "duration": 15},
		4: {"texture": "res://assets/Emotions/Wait-for-food/wait-for-food4.png", "duration": 15}
	},
	"eating": {
		1: {"duration": 20}
	}, 
	$waiting_for_check: {
		1: {"texture": "res://assets/Emotions/Wait-for-check/wait-for-check1.png", "duration": 5},
		2: {"texture": "res://assets/Emotions/Wait-for-check/wait-for-check2.png", "duration": 1},
		3: {"texture": "res://assets/Emotions/Wait-for-check/wait-for-check3.png", "duration": 1},
		4: {"texture": "res://assets/Emotions/Wait-for-check/wait-for-check4.png", "duration": 1},
	}
}

var stage_timer: Timer
@onready var eating_stage_timer = $EatingTimer
@onready var _ask_waiter = $ask_waiter
@onready var _waiting_for_food = $waiting_for_food
@onready var _waiting_for_check = $waiting_for_check

@onready var table = $".."
@onready var group = $"..".group

var current_status = 1
var active_status

func _ready():
	stage_timer = Timer.new()
	add_child(stage_timer)
	stage_timer.connect("timeout", _on_timer_timeout)

func ask_waiter():
	$ask_waiter.visible = true
	active_status = $ask_waiter
	current_status = 1
	timer_reset_start(get_current_stage()["duration"])
	
func waiting_for_food():
	$ask_waiter.visible = false
	$waiting_for_food.visible = true
	$waiting_for_check.visible = false
	active_status = $waiting_for_food
	current_status = 1
	timer_reset_start(get_current_stage()["duration"])
	
func eating_food(count):
	$ask_waiter.visible = false
	$waiting_for_food.visible = false
	$waiting_for_check.visible = false
	active_status = "eating"
	current_status = 1
	stages["eating"][current_status]["duration"] = count * 5
	eating_timer_reset_start(get_current_stage()["duration"])

func waiting_for_check():
	$ask_waiter.visible = false
	$waiting_for_food.visible = false
	$waiting_for_check.visible = true
	active_status = $waiting_for_check
	current_status = 1
	timer_reset_start(get_current_stage()["duration"])

func serve_end():
	stage_timer.stop()
	table.leave()
	reset()

func next_stage():
	current_status += 1
	if current_status == stages[active_status].size():
		last_stage()
		return
	if current_status > stages[active_status].size():
		stage_overflow()
		return
	if stage_timer:
		stage_timer.wait_time = get_current_stage()["duration"]
		active_status.texture = load(get_current_stage()["texture"])

func stage_overflow():
	print("overflow")
	
func last_stage():
	match active_status:
		_ask_waiter, _waiting_for_food:
			serve_end()
		_waiting_for_check:
			table.level.cafe_manager.manager_give_check(table)

func timer_reset_start(time):
	stage_timer.wait_time = time
	stage_timer.start()
	

func eating_timer_reset_start(time):
	eating_stage_timer.wait_time = time + 0.1
	eating_stage_timer.start()

func get_current_stage():
	return stages[active_status][current_status]

func _on_timer_timeout():
	next_stage()

func _on_eating_timer_timeout():
	table.remove_plates()

func timer_delete():
	if stage_timer != null :
		stage_timer.queue_free()

func stop_timers():
	$EatingTimer.stop()
	reset()
	if stage_timer != null:
		stage_timer.stop()

func reset():
	active_status.visible = false
	table.plate.visible = false
