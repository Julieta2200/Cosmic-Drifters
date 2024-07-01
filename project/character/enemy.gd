class_name Enemy extends Character

@onready var food = $food

enum {
	REVIEW_ANGRY,
	REVIEW_HEART
}

@onready var review_scn = $review

var review
var reviews = {
	REVIEW_ANGRY: {"texture": "res://assets/Emotions/Angry.png"},
	REVIEW_HEART: {"texture": "res://assets/Emotions/Heart.png"}
}

@onready var group = $"../.."

var table
var chair_i

var whisper_coef = 1

func _ready():
	position_delta = speed / 60

func set_heart():
	review = REVIEW_HEART
	set_review()

func set_angry():
	review = REVIEW_ANGRY
	set_review()
	
func set_review():
	review_scn.visible = true
	review_scn.texture = load(reviews[review]["texture"])

func spawn(pos):
	global_position = pos
	
func _process(_delta):
	move()

func get_food():
	return food.get_instance()

func order(i):
	var flipped = ((i == 1 && group.enemies.size() != 2) ||  i == 0)
	food.generate(flipped)
	$AnimatedSprite2D.play("talk")
	$order_timer.start()
	chair_i = i
	return food	

func _on_order_timer_timeout():
	food.visible = false
	$AnimatedSprite2D.play("idle")
	group.ordered(chair_i)
	
