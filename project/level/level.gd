class_name Level extends Node2D

var level_time: int = 500

const SPAWN_DELAY = 1
const ORDER_TIME: int = 1

var waiter_queue = []

var groups = {}
@onready var cafe_manager: CafeManager = $cafe_manager
@onready var whisper_manager: WhisperManager = $whisper_manager

func _ready():
	$Timer.wait_time = level_time
	$Timer.start()
