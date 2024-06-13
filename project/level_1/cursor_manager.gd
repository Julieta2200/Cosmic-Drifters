extends Node2D

@onready var cafe: Cafe = $"../cafe"
@onready var clickable_objects: Node2D =  cafe.clickable_objects
@onready var walking_area: Area2D = cafe.walking_area

#cursor texture dictionary
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
	get_clickable_component(walking_area).active = true

func _process(_delta):
#	if Input.is_action_just_pressed("left_click"):
#		detect_object()
	if $"../game_manager".click_area:
		change_mouse_texture()
		
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
func change_mouse_texture() -> void:
		$Timer.start()
		update_cursor()
		$"../game_manager".click_area = false

func _on_timer_timeout():
	update_cursor()
	
func detect_object() :
	for object in clickable_objects.get_children():
		if get_clickable_component(object).active:
			return object
	if get_clickable_component(walking_area).active:
		return walking_area
			
func get_clickable_component(object) -> ClickableComponent:
	for child in object.get_children():
		if child is ClickableComponent:
			return child
	return null
	

	
