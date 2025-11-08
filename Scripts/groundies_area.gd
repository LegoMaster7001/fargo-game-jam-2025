class_name GroundiesArea
extends Area2D

@export var enemy: Enemy

func try_call_groundies() -> bool:
	if not overlaps_body(enemy):
		return false
	if Global.hunted:
		return false
	Global.flip_role()
	return true
		
