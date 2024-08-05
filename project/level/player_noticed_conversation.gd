extends Conversation

func _ready():
	dialogues = [
		{"text": "I think someone is listening", "duration": 2.0, "speaker": null},
		{"text": "He's running away, get him!!!", "duration": 2.0, "speaker": null},
	]
	rend_dialog = true


func conversation_finished():
	super.conversation_finished()
	conversation_manager.run_away_player()
