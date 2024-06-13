class_name WaiterManager extends Node2D

@onready var cafe: Cafe = $"../cafe"
var queue: Array = []
@onready var level = $".."

# waiters 
@onready var waiter_1: Waiter = $Waiter_1
@onready var waiter_2: Waiter = $Waiter_2
@onready var waiter_3: Waiter = $Waiter_3
