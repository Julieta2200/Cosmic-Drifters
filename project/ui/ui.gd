extends Control

var add_minutes = 15
var items = {}

func _ready():
	$time.text = String("09:00")

func get_time() -> String:
	var time = $time.text.split(":")
	var hour = int(time[0])
	var minute = int(time[1]) + add_minutes
	if minute == 60:
		hour  = hour + 1
		minute = "00"
	if hour < 10:
		hour = "0" + str(hour)
	elif hour == 24:
		hour = "00"
	return str(hour)+ ":"+ str(minute)


func _on_timer_timeout():
	$time.text = get_time()


func add_item(table):
	var item_index = 0
	for item in $item.get_children():
		item_index  =  item_index + 1
		if item.get_child(0).text == null:
			item.get_child(0).text = "N : " + str(table.number)
			items.append({ item_index : table})
			return 

func get_table(index):
	return items[index]

func remove_item(item_index):
	$item.get_child(item_index).get_child(0).text = ""
	items.erase(item_index)
	
