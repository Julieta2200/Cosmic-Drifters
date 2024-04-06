extends CharacterBody2D

class_name Character

var position_delta: float
var target_object = null
var path: PackedVector2Array 
@onready var navigation_agent = $NavigationAgent2D
@export var speed: float
var table


#character movement
func move() -> void:
	if path.is_empty():
		if target_object != null:
			target_object.add_character($".").visible = false
#			position = target_object.add_character($".").global_position
			target_object = null
		return
		
	var direction: Vector2 = (path[0] - position).normalized()
	velocity = direction * speed
	move_and_slide()

	if position.distance_to(path[0]) < position_delta:
		path.remove_at(0)
		animation()

#character animation
func animation()-> void:
	if path.is_empty():
		$AnimatedSprite2D.play("idle")
		return

	if (path[0] - position ).y > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("back_walk")
		
#start character movement
func start_movement() -> void:
	if target_object != null:
#		target_object.place_character($".")
		table = target_object
		navigation_agent.target_position = target_object.add_character($".").global_position
	else:
		navigation_agent.target_position = get_global_mouse_position()
	table.place_character($".")
	navigation_agent.get_next_path_position()
	path = navigation_agent.get_current_navigation_path()
	animation()

