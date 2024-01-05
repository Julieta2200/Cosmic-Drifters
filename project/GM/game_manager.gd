extends Node2D

var position_delta: float
var path: PackedVector2Array
@onready var player  = $"../player"

func _ready():
	position_delta = player.speed / 60 # game is working approximately in 60 fps
	player.animation()

#player movement
func move() -> void:
	if path.is_empty():
		return

	var direction: Vector2 = (path[0] - player.position).normalized()
	player.velocity = direction * player.speed
	player.move_and_slide()

	if player.position.distance_to(path[0]) < position_delta:
		path.remove_at(0)
		player.animation()


#left mouse click in the area
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			start_movement()

#start player movement
func start_movement() -> void:
	player.navigation_agent.target_position = get_global_mouse_position()
	player.navigation_agent.get_next_path_position()
	path = player.navigation_agent.get_current_navigation_path()
	player.animation()
