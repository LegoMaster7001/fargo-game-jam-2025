extends Control

const TUTORIAL_SCENE_PATH := "res://Scenes/tutorial.tscn"

@export var start_audio: AudioStreamPlayer
@export var animation_timer: Timer
@export var animation_player: AnimationPlayer

var _current_animation_idx := 0
var _animations := ["chase_left", "chase_right"]

func _ready() -> void:
	animation_player.animation_finished.connect(play_next_animation)
	animation_player.play(_animations[_current_animation_idx])

func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_pressed():
		return
	start_audio.play()
	await start_audio.finished
	SceneSwitcher.goto_scene(TUTORIAL_SCENE_PATH)

func get_next_animation_idx() -> int:
	return (_current_animation_idx + 1) % _animations.size()

func play_next_animation(prev_anim: String) -> void:
	_current_animation_idx = get_next_animation_idx()
	animation_timer.start()
	await animation_timer.timeout
	animation_player.play(_animations[_current_animation_idx])
