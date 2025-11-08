class_name GroundiesArea
extends Area2D

@export var enemy: Enemy

func try_call_groundies() -> bool:
	if not overlaps_body(enemy):
		return false
	enemy.flip_role()
	enemy.global_position = enemy.initial_pos
	return true
		
