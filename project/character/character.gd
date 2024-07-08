class_name Character extends CharacterBody2D

var position_delta: float
var path: PackedVector2Array 
var _signal: Signal
var _signal_param

@export var character_name : String
@export var character_sprite : Texture
@onready var navigation_agent = $NavigationAgent2D
@export var speed: float

enum {LUMINA, BUNNYBOO, FROST, HOPPER, MORSEL, PRISMA, TWILIGHT , OLIVER}
var current_mask = LUMINA
static var masks = {
	LUMINA: "",
	BUNNYBOO: "bunnyboo_",
	FROST: "frost_",
	HOPPER: "hopper_",
	MORSEL: "morsel_",
	PRISMA: "prisma_",
	TWILIGHT: "twilight_",
	OLIVER : "oliver_"
}

#character movement
func move() -> void:
	if path.is_empty():
		return
		
	var direction: Vector2 = (path[0] - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	
	if global_position.distance_to(path[0]) < position_delta:
		path.remove_at(0)
		animation()
		if path.is_empty():
			if _signal_param != null:
				_signal.emit(_signal_param)
			else:
				_signal.emit()
	


#character animation
func animation()-> void:
	if path.is_empty():
		$AnimatedSprite2D.play(masks[current_mask] + "idle")
		return

	if (path[0] - global_position ).y > 0:
		$AnimatedSprite2D.play(masks[current_mask] + "walk")
	else:
		$AnimatedSprite2D.play(masks[current_mask] + "back_walk")
		
#start character movement
func start_movement(target: Vector2) -> void:
	navigation_agent.target_position = target
	navigation_agent.get_next_path_position()
	path = navigation_agent.get_current_navigation_path()
	animation()

func walk_to(pos: Vector2 , sig: Signal, sig_param = null):
	start_movement(pos)
	_signal = sig
	_signal_param = sig_param
	
	
