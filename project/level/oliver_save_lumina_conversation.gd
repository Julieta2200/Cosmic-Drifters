extends Conversation

func _ready():
	dialogues = [
		{"text": "...", "duration": 3.0, "speaker": conversation_manager},
		{"text": "Hey, it's not nice to eavesdrop", "duration": 5.0, "speaker": null},
	]

