extends Node2D

var mouse =  preload("res://assets/mouse_cursor/Mouse.png")
var click = preload("res://assets/mouse_cursor/Click.png")
var cursor_texture : Texture 

func _ready():
	cursor_texture = mouse
	get_window().size_changed.connect(update_cursor_size)
	
func _physics_process(_delta):
	update_cursor_size()
	update_cursor_texture()

func update_cursor_size() -> void:
	var current_window_size = get_window().size
	var scale_multiple = floor(current_window_size.x / 256)
	var image = cursor_texture.get_image()
	var scaler = cursor_texture.get_size() * scale_multiple 
	image.resize(scaler.x,scaler.y,Image.INTERPOLATE_NEAREST)
	var texture = ImageTexture.create_from_image(image)
	Input.set_custom_mouse_cursor(texture,Input.CURSOR_ARROW)

func _on_timer_timeout():
	cursor_texture = mouse

func update_cursor_texture() -> void:
	if $"../player".click_area:
		cursor_texture = click
		$Timer.start()
		$"../player".click_area = false

