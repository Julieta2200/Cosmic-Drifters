extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@export var speed: float

func _physics_process(_delta):
	$"../gameManager".move()

#player animation
func animation()-> void:
	if $"../gameManager".path.is_empty():
		$AnimatedSprite2D.play("idle")
		return

	if ($"../gameManager".path[0] - position ).y > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("back_walk")

