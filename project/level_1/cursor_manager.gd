extends Node2D

#corsor texture dictionary
var mouse_cursor_texture : Dictionary = {
	8 :  preload("res://assets/mouse_cursor/Mouse.png"),
	16 :  preload("res://assets/mouse_cursor/Mouse 16px.png"),
	}
var click_cursor_texture : Dictionary = {
	8 :  preload("res://assets/mouse_cursor/Click.png"),
	16 :  preload("res://assets/mouse_cursor/Click 16px.png"),
	}

func _ready():
	update_cursor()
	get_window().size_changed.connect(update_cursor)

func _process(_delta):
	click_area()
		
#update cursor 
func update_cursor() -> void:
	Input.set_custom_mouse_cursor(cursor_texture(cursor_size()),Input.CURSOR_ARROW)

#select cursor texture
func cursor_texture(size) -> Texture:
	if $"../game_manager".click_area:
		return click_cursor_texture[size]
	else:
		return mouse_cursor_texture[size]
	
#function to determine the size of the cursor
func cursor_size() -> int:
	if get_window().size.x < 720 :
		return 8
	else:
		return 16

#change mouse texture to click texture
func click_area() -> void:
	if $"../game_manager".click_area:
		$Timer.start()
		update_cursor()
		$"../game_manager".click_area = false

func _on_timer_timeout():
	update_cursor()
	


