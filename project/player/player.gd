extends CharacterBody2D

#var area: PackedScene = preload("res://project/area_2d.tscn")
var speed : int = 100
var target 


func _physics_process(delta):
	if target:
		movement()
		




#player movement
func movement():
	var direction = ($target.position)
	velocity = direction.normalized() * speed
	move_and_slide()

#left mouse click controls
func  _input(event):
	if event.is_action_pressed("left_click"):
		$"../area".position = get_viewport().get_mouse_position()
		target = $"../area".position
		$target.global_position =  target
		anim()



func _on_area_body_entered(body):
	target = null



func anim():
	if $target.position.y > 0:
		print("down")
	else:
		print("up")


