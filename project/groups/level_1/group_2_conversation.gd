extends Conversation

@export var group: Group

func _ready():
	dialogues = [
		{"text": "Do you like this place?", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Yes, it's very nice my love", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "You planned perfect day for our anniversary", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "All for you my dear.", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "The movie was also really lovely.", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Aren't they those loud folks from the movie theatre", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Ah yes, one of them was crying all movie long", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "Ah whatever, let's just enjoy our date", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "You're right as always my dear", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "I love you so much (Kent)!", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Love you too (Phunny)", "duration": 4, "speaker": group.get_enemy(0)},
	]
	
