extends CharacterBody2D

var position_delta: float
var path: PackedVector2Array
@onready var navigation_agent = $NavigationAgent2D
@export var speed: float

func _physics_process(_delta):
	move()

#player animation
func animation()-> void:
	if path.is_empty():
		$AnimatedSprite2D.play("idle")
		return

	if (path[0] - position ).y > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("back_walk")
		
func _ready():
	position_delta = speed / 60 # game is working approximately in 60 fps
	animation()

#player movement
func move() -> void:
	if path.is_empty():
		return

	var direction: Vector2 = (path[0] - position).normalized()
	velocity = direction * speed
	move_and_slide()

	if position.distance_to(path[0]) < position_delta:
		path.remove_at(0)
		animation()

#start player movement
func start_movement() -> void:
	navigation_agent.target_position = get_global_mouse_position()
	navigation_agent.get_next_path_position()
	path = navigation_agent.get_current_navigation_path()
	animation()


