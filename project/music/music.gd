extends AudioStreamPlayer

var state = true
var main = preload("res://assets/Music/gameplay.wav")
var menu = preload("res://assets/Music/menu.wav")

func play_music(music):
	stream = music
	if state:
		play()
	else:
		stop()

func main_music():
	play_music(main)

func menu_music():
	play_music(menu)
