extends Level

# seconds
const GROUP_1_SPAWN: int = 5
const SPAWN_DELAY = 1

var level_time: int = 500
var action_map: Dictionary = {
	GROUP_1_SPAWN: false
}

func _ready():
	$Timer.wait_time = level_time
	$Timer.start()

func _process(delta):
	if is_action_time(GROUP_1_SPAWN):
		group_1_spawn()

func is_action_time(t: int) -> bool:
	return round($Timer.time_left) == level_time - t && !action_map[t]


func group_1_spawn():
	action_map[GROUP_1_SPAWN] = true
	call_deferred("spawn")
	print("end_call")

func spawn():
	var enemies= $group_1.get_children()
	var i: int = 0
	for enemy in enemies:
		# enemy.spawn($spawn_point.global_position)
		print("spawn")
		# var chair = $clickable_objects/Table.get_chair(i)
		print("chair", i)
		# enemy.walk_to(chair.global_position)
		print("walking")
		i += 1
		await get_tree().create_timer(SPAWN_DELAY).timeout

