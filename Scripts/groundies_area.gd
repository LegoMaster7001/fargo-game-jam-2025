class_name GroundiesArea
extends Area2D

@export var enemy: Enemy
@onready var collisionShapes = get_children()
var ShapeToDelete

signal groundiesCalled(BodiesInArea)


func try_call_groundies() -> bool:
	if not overlaps_body(enemy):
		groundiesCalled.emit(false)
		return false
	if Global.player_is_hunter:
		groundiesCalled.emit(false)
		return false
	Global.flip_role(true)
	groundiesCalled.emit(true)
	ShapeToDelete.queue_free()
	collisionShapes.erase(ShapeToDelete) 
	return true
	

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		ShapeToDelete = collisionShapes[local_shape_index]
