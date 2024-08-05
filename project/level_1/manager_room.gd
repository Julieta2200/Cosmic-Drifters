extends Node2D


func _on_clickable_component_delete_outline():
	$outline.visible = false

func _on_clickable_component_outline():
	$outline.visible = true
