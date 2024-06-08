extends Control

@onready var table_number = $table_number/table_number
@onready var foods = $foods
@onready var orders_menu = $"../../.."
@onready var pick_btn = $pick

func _on_pick_pressed():
	orders_menu.pick(self)
