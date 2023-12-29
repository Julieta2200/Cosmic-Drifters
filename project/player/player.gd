extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@export var speed: float
var target_position: Vector2
var position_delta: float


func _ready():
	target_position = position
	position_delta = speed / 60 # game is working approximately in 60 fps

func _physics_process(_delta):
	move()

func move() -> void:
	var direction: Vector2 = (navigation_agent.get_next_path_position() - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	if position.distance_to(navigation_agent.get_next_path_position()) < position_delta:
		position = navigation_agent.get_next_path_position() #Stopped moving
		$AnimatedSprite2D.play("idle")

	
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			start_movement()

#player animation
func animation()-> void:
	if (navigation_agent.get_next_path_position() - position ).y > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("back_walk")


func start_movement() -> void:
	target_position = get_global_mouse_position()
	navigation_agent.target_position = target_position
	animation()

