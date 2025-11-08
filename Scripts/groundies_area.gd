class_name GroundiesArea
extends Area2D

@export var enemy: Enemy

func call_groundies() -> void:
	if not overlaps_body(enemy):
		print("not found")
		return
	print("noob down")
	enemy.global_position = enemy.initial_pos
