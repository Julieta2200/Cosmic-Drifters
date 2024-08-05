class_name ClickableComponent extends Area2D

var active : bool 
var parent

func _ready():
	parent = get_parent()
	
func _on_mouse_entered():
	active = true
	outline()

func _on_mouse_exited():
	active = false
	delete_outline()

func outline():
	if parent.has_method ("highlight"):
		parent.highlight()


func delete_outline():
	if parent.has_method ("highlight"):
		$"../outline".visible = false
