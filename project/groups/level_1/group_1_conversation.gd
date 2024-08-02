extends Conversation

@export var group: Group

func _ready():
	dialogues = [
		{"text": "Hello", "duration": 3, "speaker": group.get_enemy(0)},
		{"text": "Hi", "duration": 3, "speaker": group.get_enemy(1)},
		{"text": "How are you", "duration": 3, "speaker": group.get_enemy(2)},
	]
	whisper_mode = true
