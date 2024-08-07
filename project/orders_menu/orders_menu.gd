class_name OrdersMenu extends Control

@onready var orders = $main_panel/orders
var player: Player
var orders_tables = {}

func load_tables(plates, p: Player):
	player = p
	var ords = orders.get_children()
	for o in ords:
		o.visible = false
		for f in o.foods.get_children():
			f.visible = false
	
	# set orders
	var index = 0
	for table in plates:
		if table.for_lumina():
			ords[index].visible = true
			ords[index].table_number.text = "N "+str(table.number)
			orders_tables[ords[index]] = table
			ords[index].pick_btn.disabled = !player.have_empty_slot()
			var j = 0
			for food in table.actual_order:
				var f = ords[index].foods.get_children()[j]
				f.get_child(0).texture = load(food["texture"])
				f.visible = true
				j += 1
			index += 1

func close_panel():
	visible = false
	player.busy = false
	orders_tables = {}

func pick(order):
	if orders_tables.has(order):
		player.pick_plates(orders_tables[order])

func _on_cancel_pressed():
	close_panel()
