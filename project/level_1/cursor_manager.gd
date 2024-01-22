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
	click()
#		$"../game_manager".click_area = false

func updatee_cursor_texture(pixel):
	if $"../game_manager".click_area:
		print("d")
		texture = click_cursor_texture[pixel]
		$Timer.start()
		$"../game_manager".click_area = false
	else:
		print("j")
		texture = mouse_cursor_texture[pixel]
	return texture
	
func update_cursor_size():
	Input.set_custom_mouse_cursor(updatee_cursor_texture(cursor_size()),Input.CURSOR_ARROW)


func _on_timer_timeout():
	texture = mouse_cursor_texture[size]
#	Input.set_custom_mouse_cursor(texture,Input.CURSOR_ARROW)
	print("k")
#	update_cursor_size()

func click():
	if $"../game_manager".click_area:
		update_cursor_size()
		return true
