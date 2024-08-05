class_name WhisperManager extends Node2D

signal approached(data)
signal player_ready(table: Table)

var player: Player
var group : Group

@onready var security_guard = $"../security_guard"
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

