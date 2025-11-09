class_name GroundiesArea
extends Area2D

@export var enemy: Enemy

signal groundiesCalled(inArea: bool)


func try_call_groundies() -> bool:
	if not overlaps_body(enemy):
		groundiesCalled.emit(false)
		return false
	if Global.player_is_hunter:
		groundiesCalled.emit(false)
		return false
	Global.flip_role(true)
	groundiesCalled.emit(true)
	return true
		
