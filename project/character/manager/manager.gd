class_name Manager extends Waiter

var serve_table
var room_position

signal ready_sit

@export var origin_position: Marker2D
@export var chair: Sprite2D

func _physics_process(_delta):
	move()

func _ready():
	position_delta = speed / 60

func check_queue():
	pass

func walk_to_give_check(table: Table):
	busy = true
	chair.visible = true
	var serve_point = table.get_serve_point()
	walk_to(serve_point, ready_give_check , table)

func walk_to_room():
	busy = true
	walk_to(origin_position.global_position, ready_sit)

func _on_ready_give_check(table: Table):
	super._on_ready_give_check(table)
	walk_to_room()
	

func _on_ready_sit():
	chair.visible = false
	global_position = chair.global_position
