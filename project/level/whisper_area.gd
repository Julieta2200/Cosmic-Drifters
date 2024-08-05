class_name WhisperArea extends Area2D

const suspect_meter_sprites = {
	0: "res://assets/Game_UI/Scale/Scale1.png",
	1: "res://assets/Game_UI/Scale/Scale2.png",
	2: "res://assets/Game_UI/Scale/Scale3.png",
	3: "res://assets/Game_UI/Scale/Scale4.png",
	4: "res://assets/Game_UI/Scale/Scale5.png",
}


var suspect_meter: float = 0 # max value 100
var suspect_unit: float = 0
var cooldown_unit: float = 0

var enemies: Dictionary = {}
var timer: Timer
const meter_time: float = 1.0

var active: bool
var suspect_sprite: int = 0

var player: Player

@onready var whisper_manager: WhisperManager = $"../.."
@onready var meter: TextureRect = $meter
@export var table: Table

func _ready():
	timer = Timer.new()
	timer.wait_time = meter_time
	add_child(timer)
	timer.connect("timeout", update_meter)
	timer.start()

func _on_body_entered(body):
	if body is Enemy:
		enemies[body] = true
		update_units()
	
	if body is Player:
		active = true
		player = body
		if !player.busy:
			table.group.conversation.whisper_mode = false
			whisper_manager.conversation_manager.dialog.show_panel()

func _on_body_exited(body):
	if body is Enemy:
		enemies.erase(body)
		update_units()
	
	if body is Player:
		active = false
		table.group.conversation.whisper_mode = true
		whisper_manager.conversation_manager.dialog.disappear()


func update_units():
	suspect_unit = 0
	cooldown_unit = 0
	for enemy in enemies:
		if enemy.suspect_unit > suspect_unit:
			suspect_unit = enemy.suspect_unit
			cooldown_unit = enemy.cooldown_unit

func update_meter():
	if active and !player.busy:
		suspect_meter += suspect_unit
	else:
		suspect_meter -= cooldown_unit
	
	if suspect_meter > 99.9:
		suspect_meter = 99.9
		meter_full()
		return
	if suspect_meter < 0:
		suspect_meter = 0
	
	var _suspect_sprite = int(suspect_meter/20)
	if suspect_sprite != _suspect_sprite:
		suspect_sprite = _suspect_sprite
		meter.texture = load(suspect_meter_sprites[suspect_sprite])
	meter.visible = suspect_meter != 0
		
func meter_full():
	timer.paused = true
	whisper_manager.stop_player(player, table)
	
