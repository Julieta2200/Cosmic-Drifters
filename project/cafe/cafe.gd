class_name Cafe extends Node2D

signal open_food_menu(table)
signal open_orders_menu(plates)

@onready var clickable_objects: Node2D = $clickable_objects
@onready var computer: Computer = $clickable_objects/computer
@onready var spawn_point: Node2D = $spawn_point
@onready var door: AnimatedSprite2D = $details/door_animatedSprite2D
@onready var desk: Desk = $clickable_objects/desk_plates
@onready var walking_area: Area2D = $walking_area

# tables 
@onready var table1: Table = $clickable_objects/Table
@onready var table2: Table = $clickable_objects/Table2
@onready var table3: Table = $clickable_objects/Table3
@onready var table4: Table = $clickable_objects/Table4
@onready var table5: Table = $clickable_objects/Table5
@onready var table6: Table = $clickable_objects/Table6
@onready var table7: Table = $clickable_objects/TableSmall
@onready var table8: Table = $clickable_objects/TableSmall2



func _on_computer_open_food_menu(table):
	emit_signal("open_food_menu", table)


func _on_desk_plates_open_orders_menu(plates):
	emit_signal("open_orders_menu", plates)
