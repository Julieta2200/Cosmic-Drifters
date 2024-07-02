extends AnimatedSprite2D


func _on_anger_zone_body_entered(body):
	if body is Player:
		print("player_entered")



func _on_anger_zone_body_exited(body):
	if body is Player:
		print("player_exited")
