class_name Oliver extends Character

var group : Group

signal save_point
signal ready_sit

@export var origin_position: Marker2D
@export var chair: Sprite2D

func _ready():
	position_delta = speed / 60

func _physics_process(_delta):
	move()

func save_lumina(save_position, g):
	group = g
	chair.visible = true
	walk_to(save_position, save_point)

func _on_save_point():
	group.walk_to_door()
	walk_to_room()
	
func walk_to_room():
	walk_to(origin_position.global_position, ready_sit)

func _on_ready_sit():
	chair.visible = false
	global_position = chair.global_position

