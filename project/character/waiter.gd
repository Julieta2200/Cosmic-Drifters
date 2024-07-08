extends Character

class_name Waiter

@export var level: Level
@export var desk_point: Marker2D
var busy: bool = false
var on_desk: bool = true

signal ready_take_order(table: Table)
signal ready_pick_order(table: Table)
signal ready_give_order(table: Table)
signal ready_give_check(table: Table)
signal any

var action_signal: Dictionary = {
	CafeManager.TakeOrder: ready_take_order,
	CafeManager.PickOrder: ready_pick_order,
	CafeManager.GiveCheck: ready_give_check,
	"any": any
}

func _ready():
	position_delta = speed / 60
	
func _process(_delta):
	check_queue()
	move()

func check_queue():
	if busy:
		return
	
	var action = level.cafe_manager.take_waiter_action()
	if action == null:
		if !on_desk:
			on_desk = true
			walk_to(desk_point.global_position, any)
		return
		
	busy = true
	on_desk = false
	var target: Vector2
	match action["action"]:
		CafeManager.TakeOrder, CafeManager.GiveCheck:
			target = action["table"].get_serve_point()
		CafeManager.PickOrder:
			target = desk_point.global_position
	walk_to(target, get_signal(action["action"]), action["table"])

func get_signal(action) -> Signal:
	return action_signal[action]

func ask_order(table: Table):
	table.call_orders(self)

func pick_order(table: Table):
	level.cafe_manager.pick_order(table)
	var target = table.get_serve_point()
	walk_to(target, ready_give_order, table)

func give_check(table: Table):
	table.serve_end()
	busy = false
	
func give_order(table: Table):
	table.add_plates()
	busy = false
	
func ordered(table):
	busy = false
	level.cafe_manager.add_order(table)

func _on_ready_take_order(table: Table):
	ask_order(table)

func _on_ready_pick_order(table: Table):
	pick_order(table)

func _on_ready_give_order(table: Table):
	give_order(table)

func _on_ready_give_check(table: Table):
	give_check(table)
