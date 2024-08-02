class_name Conversation extends Node

@onready var dialogues: Array[Dictionary] = []

var index: int = 0
var timer: Timer
var enemies: Array[Enemy]
var whisper_mode: bool = false
@export var conversation_manager: ConversationManager

func start(e: Array[Enemy] = []):
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", dialogue_finished)
	enemies = e
	timer.one_shot = true
	_play_dialogue()
	
func stop():
	timer.stop()


func _play_dialogue():
	if index == dialogues.size():
		conversation_finished()
		return
	
	var dialogue = dialogues[index]
	timer.wait_time = dialogue["duration"]
	if !whisper_mode:
		if dialogue["speaker"] != null:
			conversation_manager.dialog.appear(dialogue["text"],
			 dialogue["speaker"].character_name,
			 dialogue["speaker"].character_sprite)
		elif enemies.size() > 0:
			randomize()
			var rand_ind: int = randi() % enemies.size()
			conversation_manager.dialog.appear(dialogue["text"],
			 enemies[rand_ind].character_name,
			 enemies[rand_ind].character_sprite)
	timer.start()
	
func dialogue_finished():
	index += 1
	_play_dialogue()

func conversation_finished():
	conversation_manager.dialog.disappear()
