extends CharacterBody2D


var speed = 200
var click_mous_pos = null

func  _input(event):
	if event.is_action_pressed("left_click"):
		click_mous_pos = get_viewport().get_mouse_position()
	
	
func _physics_process(_delta):
	if click_mous_pos:
		var direction_vector = (click_mous_pos - global_position)
		
		if direction_vector.length() < 3:
			return
			
		velocity = direction_vector.normalized() * speed
		move_and_slide()
		
		
