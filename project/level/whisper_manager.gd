class_name WhisperManager extends Node2D

signal approached(data)
signal player_ready(table: Table)

var player: Player
var group : Group

@onready var oliver = $"../oliver"
@onready var level: Level
var current_table: Table
@export var conversation_manager: ConversationManager

func stop_player(p: Player, table: Table):
	player = p
	player.busy = true
	current_table = table
	current_table.group_status.stop_timers()
	conversation_manager.player_noticed_conversation.start(table.group.enemies)

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
		conversation_manager.player_approach_conversation.start(data["enemies"])
		if !oliver.busy:
			security_guard_save_lumina(player.get_save_point())



func _on_player_ready(table):
	approach_player(table)

func security_guard_save_lumina(save_position):
	oliver.save_lumina(save_position)

