class_name Manager extends Waiter

var serve_table
var room_position

signal ready_sit

@export var origin_position: Marker2D
@export var chair: Sprite2D

enum Emotions {alert, angry, none}
const emotion_sprites: Dictionary = {
	Emotions.alert: "res://assets/Emotions/Exclamation_point.png",
	Emotions.angry: "res://assets/Emotions/Angry.png"
}

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
	

func set_emotion(emotion: Emotions):
	if emotion == Emotions.none:
		$emotion.visible = false
		return
	
	$emotion.texture = load(emotion_sprites[emotion])
	$emotion.visible = true

func _on_ready_sit():
	chair.visible = false
	global_position = chair.global_position
