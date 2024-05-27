class_name Enemy extends Character

@onready var food = $food
var rng = RandomNumberGenerator.new()
var table
var chair_i

func _ready():
	position_delta = speed / 60

func spawn(pos):
	global_position = pos
	
func _process(delta):
	move()


func order(t, i):
	food.food_sp.texture = load(food.foods[rng.randf_range(0,food.foods.size())])
	food.visible = true
	$AnimatedSprite2D.play("talk")
	$order_timer.start()
	table = t
	chair_i = i
	food.prepare(table)
	return food	

func _on_order_timer_timeout():
	food.visible = false
	$AnimatedSprite2D.play("idle")
	table.ordered(chair_i)
	
