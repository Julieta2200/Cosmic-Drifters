class_name ConversationManager extends Node2D

@export var dialog: Dialog
@export var player: Player
@export var whisper_manager: WhisperManager
@export var oliver : Oliver

@onready var player_approach_conversation: Conversation = $player_approach_conversation
@onready var player_noticed_conversation: Conversation = $player_noticed_conversation
@onready var oliver_save_lumina_conversation = $oliver_save_lumina_conversation
