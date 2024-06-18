class_name Tutorial extends Level

var tutorial_mode: bool = false
@onready var text_dialog: Dialog = $CanvasLayer/dialog
@onready var boss: Boss = $boss
@onready var player: Player = $clickable_objects/player

var _timer: Timer

func _ready():
	groups = {}

func _process(_delta):
	for k in groups:
		if is_spawn_time(groups[k]):
			spawn(groups[k])

func intro_dialog():
	text_dialog.appear("Agent Lumina, can you hear me?","????", boss.character_sprite)
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_reset_timer(2.0, _intro_dialog_rendered, _intro_dialog_rendered)
	
func _reset_timer(time: float, prev: Callable, next: Callable):
	_timer.disconnect("timeout", prev)
	_timer.wait_time = time
	_timer.connect("timeout", next)
	_timer.start()

func _intro_dialog_rendered():
	text_dialog.appear("...", player.character_name, player.character_sprite)
	_reset_timer(1.0, _intro_dialog_rendered, _lumina_dialog_rendered1)

func _lumina_dialog_rendered1():
	text_dialog.appear("I’m the agent who’s assigned to help you with the undercover mission.", "????", boss.character_sprite)
	_reset_timer(2.0, _lumina_dialog_rendered1, _name_reveal)

func _name_reveal():
	text_dialog.appear("My code name is Nebula, want to know my real name?", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _name_reveal, _lumina_dialog_rendered2)

func _lumina_dialog_rendered2():
	text_dialog.appear("...", player.character_name, player.character_sprite)
	_reset_timer(2.0, _lumina_dialog_rendered2, _start_instructions)

func _start_instructions():
	pass
