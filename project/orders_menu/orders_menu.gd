extends Control

@onready var orders = $main_panel/orders

func load_tables(plates):
	var ords = orders.get_children()
	var index = 0
	for group in plates:
		if group.has("for_lumina"):
			ords[index].visible = true
			ords[index].table_number.text = "N "+str(group["table"].number)
			var j = 0
			for food in group["table"].actual_order:
				ords[index].foods.get_children()[j].get_child(0).texture = load(food["texture"])
				j += 1
			index += 1
