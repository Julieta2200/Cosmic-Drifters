class_name CafeManager extends Node2D

enum {TakeOrder, PickOrder, GiveCheck}

@onready var kitchen: Kitchen = $"../kitchen"
@onready var desk: Desk = $"../clickable_objects/desk_plates"

@onready var manager: Manager = $"../manager"
@onready var oliver = $"../oliver"
@onready var player = $"../clickable_objects/player"

var _waiters_actions: Array

func ask_waiters(group: Group):
	_waiters_actions.append({"table": group.get_table(), "action": TakeOrder})

func take_waiter_action():
	if len(_waiters_actions) == 0:
		return null
	
	var action = _waiters_actions[0]
	_waiters_actions.remove_at(0)
	return action

func add_order(table: Table):
	kitchen.add_order(table)

func order_ready(table: Table):
	desk.add_plate(table)
	if !table.for_lumina():
		_waiters_actions.append({"table": table, "action": PickOrder})

func pick_order(table: Table):
	desk.remove_plate(table)

func ask_for_check(table: Table):
	if !table.for_lumina():
		_waiters_actions.append({"table": table, "action": GiveCheck})

func manager_give_check(table: Table):
	manager.walk_to_give_check(table)


