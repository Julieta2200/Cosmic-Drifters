class_name Oliver extends Character

var busy : bool

signal save_point
signal ready_sit
signal talk

@export var origin_position: Marker2D
@export var chair: Sprite2D

@onready var timer = $talk_timer
@onready var whisper_manager : WhisperManager = $"../whisper_manager"

func _ready():
	position_delta = speed / 60

func _physics_process(_delta):
	move()

func save_lumina(save_position):
	busy = true
	chair.visible = true
	walk_to(save_position, save_point)

func _on_save_point():
	talk.emit()

func walk_to_room():
	walk_to(origin_position.global_position, ready_sit)

func _on_ready_sit():
	chair.visible = false
	global_position = chair.global_position

func _on_timer_timeout():
	busy = false
	whisper_manager.group.walk_to_door()
	whisper_manager.player.make_free()
	walk_to_room()
