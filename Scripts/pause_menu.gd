class_name PauseMenu
extends Control

@export var audio: AudioStreamPlayer

func _input(event: InputEvent) -> void:
	if Global.game_over:
		return
	if event.is_action_pressed("pause"):
		audio.play()
		get_tree().paused = false
		hide()
		get_viewport().set_input_as_handled()
