class_name Tutorial extends Level

var tutorial_mode: bool = false
@onready var text_dialog: Dialog = $CanvasLayer/dialog
@onready var boss: Boss = $boss

func _ready():
	groups = {}

func _process(_delta):
	for k in groups:
		if is_spawn_time(groups[k]):
			spawn(groups[k])

func intro_dialog():
	text_dialog.appear("Hellooo", boss.character_name, boss.character_sprite)
