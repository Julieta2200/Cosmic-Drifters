extends Node2D

#var mouse =  preload("res://assets/mouse_cursor/Mouse.png")
#var click = preload("res://assets/mouse_cursor/Click.png")
#var cursor_texture : Texture 
#var cu
#
#func _ready():
#	cursor_texture = mouse
##	get_window().size_changed.connect(update_cursor_size)
#
#func _physics_process(_delta):
#	update_cursor_size()
#	update_cursor_texture()
#
#func update_cursor_size() -> void:
#	var current_window_size = get_window().size
#	var scale_multiple = floor(current_window_size.x / 256)
#	var image = cursor_texture.get_image()
#	var scaler = cursor_texture.get_size() * scale_multiple 
#	image.resize(scaler.x,scaler.y,Image.INTERPOLATE_NEAREST)
#	var texture = ImageTexture.create_from_image(image)
#	Input.set_custom_mouse_cursor(texture,Input.CURSOR_ARROW)
#
#func _on_timer_timeout():
#	cursor_texture = mouse
#
#func update_cursor_texture() -> void:
#	if $"../player".click_area:
#		cursor_texture = click
#		$Timer.start()
#		$"../player".click_area = false
#
var cursor_texture : Dictionary = {
	"mouse8" :  preload("res://assets/mouse_cursor/Mouse.png"),
	"mouse16" :  preload("res://assets/mouse_cursor/Mouse 16px.png"),
	}
	
func _ready():
	update_cursor_size()
	get_window().size_changed.connect(update_cursor_size)
	
func update_cursor_size() -> void:
	if get_window().size.x < 1024 :
		Input.set_custom_mouse_cursor(f(8),Input.CURSOR_ARROW)
	else:
		Input.set_custom_mouse_cursor(cursor_texture["mouse16"],Input.CURSOR_ARROW)

func f(k):
	if k == 8:
		return cursor_texture["mouse8"]
	elif k == 16:
		return cursor_texture["mouse16"]
	
