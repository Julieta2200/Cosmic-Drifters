extends Conversation

func _ready():
	dialogues = [
		{"text": "Hey, it's not nice to eavesdrop", "duration": 5.0, "speaker": null},
		{"text": "...", "duration": 3.0, "speaker": conversation_manager.player},
		{"text": "I don't think he's a regular waiter", "duration": 5.0, "speaker": null},
	]


