class_name ClickableComponent extends Area2D

var active : bool 
signal outline
signal delete_outline

func _on_mouse_entered():
	active = true
	outline.emit()

func _on_mouse_exited():
	active = false
	delete_outline.emit()
