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
	food.food_sp.texture = load(food.foods[rng.randf_range(0,food.foods.size())])
	food.visible = true
	$AnimatedSprite2D.play("talk")
	level = node
	ch_action = action
	$order_timer.start()
	food.prepare(action, node)

func _on_order_timer_timeout():
	food.visible = false
	$AnimatedSprite2D.play("idle")
	level.action_complete(ch_action)
