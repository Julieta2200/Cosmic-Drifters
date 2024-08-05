extends Conversation

func _ready():
	dialogues = [
		{"text": "You disturb the rest of the guests", "duration": 3.0, "speaker": conversation_manager.oliver},
	]

func conversation_finished():
	super.conversation_finished()
	conversation_manager.oliver.walk_to_room()
