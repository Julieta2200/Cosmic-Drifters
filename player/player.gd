extends CharacterBody2D


var speed : int = 200
var click_mouse_position : Vector2


func _physics_process(_delta):
	if click_mouse_position:
		_movement()




#player movement
func _movement():
		var direction = (click_mouse_position - global_position)
		velocity = direction.normalized() * speed
		move_and_slide()

#left mouse click controls
func  _input(event):
	if event.is_action_pressed("left_click"):
		click_mouse_position = get_viewport().get_mouse_position()
	
