extends Conversation

@export var oliver : Oliver

func _ready():
	dialogues = [
		{"text": "You disturb the rest of the guests", "duration": 3.0, "speaker": oliver},
	]

