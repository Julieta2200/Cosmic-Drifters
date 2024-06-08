extends Node2D

class_name Status


@onready var stages = {
	$ask_waiter: {
		1: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Green).png", "duration": 3},
		2: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Orange).png", "duration": 3},
		3: {"texture": "res://assets/Emotions/Exclamation_mark/Exclamation_mark(Red).png", "duration": 3},
		4: {"texture": "res://assets/Emotions/Exclamation_mark/ExclamationMark(Fier1).png", "duration": 3}
	}
}

@onready var stage_timer = $Timer

var current_status = 1
var active_status

func ask_waiter():
	$ask_waiter.visible = true
	active_status = $ask_waiter
	current_status = 1
	timer_reset_start(get_current_stage()["duration"])

func next_stage():
	current_status += 1
	if current_status > stages[active_status].size():
		stage_overflow()
		return
	active_status.texture = load(get_current_stage()["texture"])

func stage_overflow():
	print("overflow")

func timer_reset_start(time):
	stage_timer.wait_time = time
	stage_timer.start()

func get_current_stage():
	return stages[active_status][current_status]

func _on_timer_timeout():
	next_stage()
