class_name Tutorial extends Level

var tutorial_mode: bool = false
@onready var text_dialog: Dialog = $CanvasLayer/dialog
@onready var boss: Boss = $boss
@onready var player: Player = $clickable_objects/player
@onready var arrows: TextureRect = $CanvasLayer/tutorial_assets/arrows
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
	text_dialog.appear("You seem like a very talkative person, anyways let’s start with your instructions, shall we?", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _start_instructions, _greetings)

func _greetings():
	text_dialog.appear("Welcome to Cosmic Whispers cafe!!!", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _greetings, _objective)

func _objective():
	text_dialog.appear("Your main objective is to get intel from some visitors who are connected with intergalactic crime organizations.", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _objective, _warning)

func _warning():
	text_dialog.appear("Cafes manager Frostwirl has no idea that you’re an agent, so you should be careful to not to get fired.", boss.character_name, boss.character_sprite)
	_reset_timer(2.0, _warning, _use_arrows)

func _use_arrows():
	arrows.visible = true
	text_dialog.appear("Use arrows to navigate through cafe", boss.character_name, boss.character_sprite)
