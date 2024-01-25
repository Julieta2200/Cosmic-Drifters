extends Node2D

var size
var texture
var mouse_cursor_texture : Dictionary = {
	8 :  preload("res://assets/mouse_cursor/Mouse.png"),
	16 :  preload("res://assets/mouse_cursor/Mouse 16px.png"),
	}

var click_cursor_texture : Dictionary = {
	8 :  preload("res://assets/mouse_cursor/Click.png"),
	16 :  preload("res://assets/mouse_cursor/Click 16px.png"),
	}
	
func _ready():
	update_cursor_size()
	get_window().size_changed.connect(update_cursor_size)
	
func cursor_size() -> int:
#	var size : int
	if get_window().size.x < 720 :
		size = 8
	else:
		size = 16
	return size

func _process(delta):
	if $"../game_manager".click_area:
		click()

func updatee_cursor_texture(pixel):
	if $"../game_manager".click_area:
		texture = click_cursor_texture[pixel]
		$"../game_manager".click_area = false
	else:
		texture = mouse_cursor_texture[pixel]
	return texture
	
	
func update_cursor_size():
	Input.set_custom_mouse_cursor(updatee_cursor_texture(cursor_size()),Input.CURSOR_ARROW)


func _on_timer_timeout():
	update_cursor_size()


func click():
	update_cursor_size()
	$Timer.start()
