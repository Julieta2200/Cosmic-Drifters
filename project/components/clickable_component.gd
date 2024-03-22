class_name ClickableComponent extends Area2D

var active : bool 

func _on_mouse_entered():
	active = true


func _on_mouse_exited():
	active = false

