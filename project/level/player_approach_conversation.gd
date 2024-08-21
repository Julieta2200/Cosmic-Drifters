extends Conversation

func _ready():
	dialogues = [
		{"text": "Hey, it's not nice to eavesdrop", "duration": 2.0, "speaker": null},
		{"text": "...", "duration": 1.0, "speaker": conversation_manager.player},
		{"text": "I don't think he's a regular waiter", "duration": 2.0, "speaker": null},
	]
	rend_dialog = true


