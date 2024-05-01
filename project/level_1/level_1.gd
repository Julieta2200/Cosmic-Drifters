extends Level

# seconds
const GROUP_1_SPAWN: int = 5
const SPAWN_DELAY = 1
const GROUP_1_SERVE: int = 7

var level_time: int = 500
var action_map: Dictionary = {
	GROUP_1_SPAWN: false,
	GROUP_1_SERVE: false
}

@onready var group_1 = {
	"group": $group_1,
	"table": $clickable_objects/Table,
	"waiter": $Waiter_1
}

func _ready():
	$Timer.wait_time = level_time
	$Timer.start()

func _process(delta):
	if is_action_time(GROUP_1_SPAWN):
		group_1_spawn()
	elif is_action_time(GROUP_1_SERVE):
		group_1_serve()

func is_action_time(t: int) -> bool:
	return round($Timer.time_left) == level_time - t && !action_map[t]


func group_1_spawn():
	action_map[GROUP_1_SPAWN] = true
	call_deferred("spawn_and_sit")
	print("end_call")

func spawn_and_sit():
	var enemies= group_1["group"].get_children()
	var i: int = 0
	for enemy in enemies:
		enemy.spawn($spawn_point.global_position)
		var chair = group_1["table"].get_chair(i)
		enemy.walk_to(chair.global_position)
		print(chair.global_position)
		i += 1
		await get_tree().create_timer(SPAWN_DELAY).timeout
		
func group_1_serve():
	action_map[GROUP_1_SERVE] = true
	# var serve_point = group_1["table"].get_serve_point()
	print("serve_point")
	# group_1["waiter"].walk_to(serve_point.global_position)
	print("waiter walking")
	

