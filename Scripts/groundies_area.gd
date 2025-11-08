class_name GroundiesArea
extends Area2D

@export var enemy: Enemy

func try_call_groundies() -> bool:
	if not overlaps_body(enemy):
		print("epic fail")
		return false
	print("noob down")
	enemy.flip_role()
	return true
		
