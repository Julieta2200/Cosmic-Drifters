extends Conversation

@export var group: Group

func _ready():
	dialogues = [
		{"text": "Is everything ready?", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "I always keep my promises.", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "You better be...", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "You better be...", "duration": 4, "speaker": group.get_enemy(3)},
		{"text": "...", "duration": 1, "speaker": group.get_enemy(2)},
		{"text": "Who will call the police?", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "There’s a phonebooth near the (Milky Way) museum, one of your minions can make the call", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "We’re not minions...", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "We’re not minions...", "duration": 4, "speaker": group.get_enemy(3)},
		{"text": "Whatever, just to the call at (11:45)", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "Got it!", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "Got it!", "duration": 4, "speaker": group.get_enemy(3)},
		{"text": "Are they always repeating eachother?", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "Ah, over time you'll get used to it", "duration": 4, "speaker": group.get_enemy(1)},
	]
