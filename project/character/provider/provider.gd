class_name Provider extends Character

@export var conversation_manager : ConversationManager 

func start_talking():
	conversation_manager.provider_coversation.start()

func _on_clickable_component_delete_outline():
	$outline.visible = false

func _on_clickable_component_outline():
	$outline.visible = true
