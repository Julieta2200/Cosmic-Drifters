class_name Table extends Node2D

const ORDER_INTERVAL: int = 1
const suspect_meter_sprites = {
	0: "res://assets/Game_UI/Scale/Scale1.png",
	1: "res://assets/Game_UI/Scale/Scale2.png",
	2: "res://assets/Game_UI/Scale/Scale3.png",
	3: "res://assets/Game_UI/Scale/Scale4.png",
	4: "res://assets/Game_UI/Scale/Scale5.png",
}

@onready var plate = $plate
@onready var chairs = $chairs
@onready var group_status: Status = $status
@onready var meter: TextureRect = $meter

@export var number: int

@export var level: Level
var outline
var rng = RandomNumberGenerator.new()
var waiter: Waiter
var group: Group

var plates = ["res://assets/Food/Plate/plate_1.png","res://assets/Food/Plate/plate_2.png",
				"res://assets/Food/Plate/plate_3.png","res://assets/Food/Plate/plate_4.png",
				"res://assets/Food/Plate/plate_5.png","res://assets/Food/Plate/plate_6.png"]

var actual_order = []
var plates_to_remove = []


var food_action = false

# recording
var recorded: bool
var suspect_meter: float = 0 # max value 100
var suspect_unit: float = 10
var cooldown_unit: float = 5
var suspect_sprite: int = 0
var timer: Timer
const meter_time: float = 1.0

func _ready():
	timer = Timer.new()
	timer.wait_time = meter_time
	add_child(timer)
	timer.connect("timeout", update_meter)
	timer.start()

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

func highlight():
	if for_lumina():
		match  group.current_status:
			group.STATUS_ASKING_FOR_WAITER,group.STATUS_WAITING_FOR_FOOD,group.STATUS_WAITING_FOR_CHECK:
				$outline.visible = true
		


func _on_clickable_component_outline():
	if for_lumina():
		match  group.current_status:
			group.STATUS_ASKING_FOR_WAITER,group.STATUS_WAITING_FOR_FOOD,group.STATUS_WAITING_FOR_CHECK:
				$outline.visible = true


func _on_clickable_component_delete_outline():
	$outline.visible = false


func update_meter():
	if recorded:
		suspect_meter += suspect_unit
	else:
		suspect_meter -= cooldown_unit
	
	if suspect_meter > 99.9:
		suspect_meter = 99.9
		meter_full()
		return
	if suspect_meter < 0:
		suspect_meter = 0
	
	var _suspect_sprite = int(suspect_meter/20)
	if suspect_sprite != _suspect_sprite:
		suspect_sprite = _suspect_sprite
		meter.texture = load(suspect_meter_sprites[suspect_sprite])
	meter.visible = suspect_meter != 0
		
func meter_full():
	timer.paused = true
	level.conversation_manager.player.stop_recording()
	level.conversation_manager.player.busy = true
	level.conversation_manager.current_table = self
	group_status.stop_timers()
	level.conversation_manager.player_noticed_conversation.start(group.enemies)
