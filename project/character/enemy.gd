class_name Enemy extends Character

@onready var food = $food

var table
var chair_i

func _ready():
	position_delta = speed / 60

func spawn(pos):
	global_position = pos
	
func _process(_delta):
	move()


func order(t, i):
	var flipped = ((i == 1 && t.chairs.get_children().size() != 2) ||  i == 0)
	food.generate(flipped)
	$AnimatedSprite2D.play("talk")
	$order_timer.start()
	table = t
	chair_i = i
	return food	

func _on_order_timer_timeout():
	food.visible = false
	$AnimatedSprite2D.play("idle")
	table.ordered(chair_i)
	
