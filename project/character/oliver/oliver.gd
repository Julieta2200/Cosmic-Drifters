class_name Oliver extends Character

var busy : bool

signal save_point
signal ready_sit

@export var origin_position: Marker2D
@export var chair: Sprite2D
@onready var whisper_manager : WhisperManager = $"../whisper_manager"
@onready var conversation_manager : ConversationManager = $"../conversation_manager"

func _ready():
	position_delta = speed / 60

func _physics_process(_delta):
	move()

func save_lumina(save_position):
	busy = true
	chair.visible = true
	walk_to(save_position, save_point)

func _on_save_point():
	conversation_manager.oliver_save_lumina_conversation.start()

func walk_to_room():
	busy = false
	conversation_manager.group.walk_to_door()
	conversation_manager.player.make_free()
	walk_to_room()
	
func walk_to_room():
	walk_to(origin_position.global_position, ready_sit)

func _on_ready_sit():
	chair.visible = false
	global_position = chair.global_position

