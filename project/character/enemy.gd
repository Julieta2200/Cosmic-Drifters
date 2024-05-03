class_name Enemy extends Character

@onready var food = $food
var rng = RandomNumberGenerator.new()

func _ready():
	position_delta = speed / 60

func spawn(pos):
	global_position = pos
	
func _process(delta):
	move()


func order(node : Node2D, action: String):
	food.food_sp.texture = food.foods[rng.randf_range(0,food.foods.size())]
	food.visible = true
	level = node
	ch_action = action
	$Timer.start()

func _on_timer_timeout():
	food.visible = false
	level.action_complete(ch_action)
