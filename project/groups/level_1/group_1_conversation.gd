extends Conversation

@export var group: Group

func _ready():
	dialogues = [
		{"text": "What a long movie!", "duration": 4, "speaker": group.get_enemy(3)},
		{"text": "Yeah, I'm super hungry now.", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "Ah, come on, you're always hungry!", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Who wants to join me for some shopping?", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "I'm too scared to be out late. Did you hear the latest news?", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "You mean the kidnappings?", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Yes, I've heard about that too, but I think all of the victims were archaeologists.", "duration": 4, "speaker": group.get_enemy(3)},
		{"text": "I think it's the work of some gang.", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "Let's not talk about scary topics. I'm losing my appetite.", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "Well, maybe it'll help you with your diet. Hahaha xD", "duration": 4, "speaker": group.get_enemy(1)},
		{"text": "Very funny :/", "duration": 4, "speaker": group.get_enemy(0)},
		{"text": "I think this new waiter is very cute =D", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "Didn't you just go through a breakup?", "duration": 2, "speaker": group.get_enemy(3)},
		{"text": "I'm over it.", "duration": 4, "speaker": group.get_enemy(2)},
		{"text": "Sure, you were crying during the whole movie.", "duration": 4, "speaker": group.get_enemy(1)},
	]
	
