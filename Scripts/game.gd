class_name Game
extends Node2D

func _ready() -> void:
	Global.current_role = Global.role.hunted
	Global.chase_timer.start()
	get_tree().paused = false
