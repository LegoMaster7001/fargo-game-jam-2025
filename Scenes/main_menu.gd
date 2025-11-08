extends Control

@export var animation_timer: Timer
@export var animation_player: AnimationPlayer

var _current_animation_idx := 0
var _animations := ["chase_left", "chase_right"]

func _ready() -> void:
	animation_player.animation_finished.connect(play_next_animation)
	animation_player.play(_animations[_current_animation_idx])

func get_next_animation_idx() -> int:
	return (_current_animation_idx + 1) % _animations.size()

func play_next_animation(prev_anim: String) -> void:
	_current_animation_idx = get_next_animation_idx()
	animation_timer.start()
	await animation_timer.timeout
	animation_player.play(_animations[_current_animation_idx])
