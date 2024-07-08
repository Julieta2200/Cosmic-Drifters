class_name TopUI extends Control

var add_minutes = 15
var items = {}

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
	var index = 0
	for item in $item.get_children():
		index = index + 1
		if item.get_child(0).text == "":
			item.get_child(0).text = "N : " + str(table.number)
			items[index] = table
			return 

func get_item_index(item):
	for index in items:
		if items[index] == item:
			return index
	return -1

func get_item(index):
	return items[index]

func remove_item(index):
	$item.get_child(index-1).get_child(0).text = ""
	items.erase(index)
	
