extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var progressBar : ProgressBar = $Panel/ProgressBar

func _update_progress_bar(new_value: float) -> void:
	progressBar.set_value_no_signal(new_value * 100)
	
func _start_outro_animation() -> void:
	animationPlayer.play("end_load")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"end_load":
			self.queue_free()
