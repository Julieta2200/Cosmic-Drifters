extends Node2D

#coursor texture dictionary
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

func _process(delta):
	click_area_bool()
		
# update cursor size
func update_cursor_size() -> void:
	Input.set_custom_mouse_cursor(cursor_texture(cursor_size()),Input.CURSOR_ARROW)

# update cursor texture
func cursor_texture(pixel) -> Texture:
	if $"../game_manager".click_area:
		$"../game_manager".click_area = false
		return click_cursor_texture[pixel]
	else:
		return mouse_cursor_texture[pixel]
	
# function to determine the size of the cursor
func cursor_size() -> int:
	if get_window().size.x < 720 :
		return 8
	else:
		return 16


func click_area_bool() -> void:
	if $"../game_manager".click_area:
		update_cursor_size()
		$Timer.start()

func _on_timer_timeout():
	update_cursor_size()


