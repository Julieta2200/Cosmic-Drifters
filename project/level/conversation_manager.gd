class_name ConversationManager extends Node2D

@export var dialog: Dialog
@export var player: Player
@export var whisper_manager: WhisperManager

@onready var player_approach_conversation: Conversation = $player_approach_conversation
@onready var player_noticed_conversation: Conversation = $player_noticed_conversation
@onready var security_guard = $"../security_guard"
var group : Group

signal approached(data)
signal player_ready(table: Table)

var current_table: Table

func record(text: String):
	player.record(text)

func run_away_player():
	player.walk_to(current_table.get_approach_point().global_position, player_ready, current_table)

func approach_player(table: Table):
	group = table.group
	var points = player.get_approach_points()
	var enemies = table.group.enemies
	for i in range(enemies.size()):
		enemies[i].set_angry()
		table.reset()
		table.leave_chair(i)
		enemies[i].walk_to(points[i].global_position, approached, {"enemies": enemies, "index": i})


func _on_approached(data):
	if data["index"] == data["enemies"].size() - 1:
		player_approach_conversation.start(data["enemies"])
		if !security_guard.busy:
			security_guard_save_lumina(player.get_save_point())



func _on_player_ready(table):
	approach_player(table)

func security_guard_save_lumina(save_position):
	security_guard.save_lumina(save_position)
