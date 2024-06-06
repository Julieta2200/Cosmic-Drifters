extends Control

var add_minutes = 15

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
