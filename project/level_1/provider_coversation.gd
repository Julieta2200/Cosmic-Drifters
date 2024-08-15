extends Conversation


func _ready():
	rend_dialog = true
	dialogues = [
		{"text": "There are no recordings!", "duration": 3.0, "speaker": conversation_manager.provider},
	]

func conversation_finished():
	super.conversation_finished()
	conversation_manager.player.make_free()
