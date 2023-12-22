extends CharacterBody2D

@export var speed: float
var target_position: Vector2
var position_delta: float

func _ready():
	target_position = position
	position_delta = speed / 60 # game is working approximately in 60 fps

func _physics_process(_delta):
	move()

func move() -> void:
	var direction: Vector2 = (target_position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if position.distance_to(target_position) < position_delta:
		position = target_position #Stopped moving
		$AnimatedSprite2D.play("stand")  
	
	
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			start_movement()

#player animation
func animation()-> void:
	if (target_position - position).y > 0:
		$AnimatedSprite2D.play("walk_down")
	else:
		$AnimatedSprite2D.play("walk_up")


func start_movement() -> void:
	target_position = get_global_mouse_position()
	animation()

