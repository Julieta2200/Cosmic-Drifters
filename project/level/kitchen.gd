extends Node2D

func prepare_food(level, food):
	call_deferred("prepare", level, food)
	
func prepare(level, food):
	await get_tree().create_timer(food.prep_time).timeout
	

