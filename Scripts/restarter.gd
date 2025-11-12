class_name Restarter
extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		# if not Global.game_over:
		# 	return
		Global.restart()
		get_tree().reload_current_scene()
