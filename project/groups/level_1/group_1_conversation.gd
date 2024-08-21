extends Conversation

@export var group: Group

func _ready():
	dialogues = [
		{"text": "I’ve been watching a new crime drama. The twists are amazing.", "duration": 4, "speaker": group.get_enemy(0)},  # Grand
		{"text": "I love shows about stars and galaxies. Have you seen one where they solve mysteries using constellations?", "duration": 4, "speaker": group.get_enemy(1)},  # Gerald
		{"text": "I prefer shows with edge. Some crime dramas are surprisingly accurate.", "duration": 4, "speaker": group.get_enemy(2)},  # Ralph
		{"text": "I’m here for action and laughs. What’s trending in TV these days?", "duration": 4, "speaker": group.get_enemy(3)},  # Kafka
		{"text": "There’s a funny show about friends running a restaurant. It’s surprisingly good.", "duration": 4, "speaker": group.get_enemy(0)},  # Grand
		{"text": "That sounds intriguing. TV shows can be as complex as cosmic events.", "duration": 4, "speaker": group.get_enemy(1)},  # Gerald
		{"text": "I like shows with dark secrets. They’re interesting to watch.", "duration": 4, "speaker": group.get_enemy(2)},  # Ralph
		{"text": "I love shows with hidden secrets! What’s the best one you’ve seen recently?", "duration": 4, "speaker": group.get_enemy(3)},  # Kafka
		{"text": "A cooking show I mentioned is great. Watching chefs get flustered is hilarious.", "duration": 4, "speaker": group.get_enemy(0)},  # Grand
		{"text": "Sounds like a cosmic adventure! Handling pressure can be fascinating.", "duration": 4, "speaker": group.get_enemy(1)},  # Gerald
		{"text": "As long as it’s not too sappy, I’m in. Sometimes less serious is better.", "duration": 4, "speaker": group.get_enemy(2)},  # Ralph
		{"text": "Cheers to discovering new shows and having fun!", "duration": 4, "speaker": group.get_enemy(3)},  # Kafka
		{"text": "Cheers!", "duration": 2, "speaker": group.get_enemy(0)},  # Grand
		{"text": "To the wonders of the universe and great stories.", "duration": 4, "speaker": group.get_enemy(1)},  # Gerald
		{"text": "And to the complexity of it all.", "duration": 4, "speaker": group.get_enemy(2)},  # Ralph
	]
	
