extends Control

func pause():
	get_tree().paused = true
	$backgroun_panel.visible = true
	$menu.visible = true
	
func resume():
	get_tree().paused = false
	$backgroun_panel.visible = false
	$menu.visible = false

func _on_pause_pressed():
	pause()


func _on_resume_pressed():
	resume()



