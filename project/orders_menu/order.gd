extends Control

@onready var table_number = $table_number/table_number
@onready var foods = $foods
@onready var orders_menu = $"../../.."

func _on_pick_pressed():
	orders_menu.pick(self)
