class_name WhisperManager extends Node2D

signal approached
signal player_ready(table: Table)

var player: Player
@onready var security_guard = $"../security_guard"

func stop_player(p: Player, table: Table):
	player = p
	player.busy = true
	player.walk_to(table.get_approach_point().global_position, player_ready, table)

func approach_player(table: Table):
	var points = player.get_approach_points()
	var enemies = table.group.enemies
	for i in range(enemies.size()):
		enemies[i].set_angry()
		enemies[i].walk_to(points[i].global_position, approached)
	security_guard_save_lumina(player.get_save_point(), table.group)

func _on_approached():
	print("approached")

func _on_player_ready(table):
	approach_player(table)

func security_guard_save_lumina(pos, group):
	security_guard.save_lumina(pos, group)
