class_name GroundiesArea
extends Area2D

@export var enemy: Enemy
@onready var collisionShapes = get_children()
var ShapeToDelete : CollisionShape2D

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
	ShapeToDelete.shape.size = Vector2 (0, 0)
	var mesh2d : MeshInstance2D
	mesh2d = ShapeToDelete.get_child(0)
	mesh2d.modulate.a = 0.5
	collisionShapes.erase(ShapeToDelete)
	return true
	

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		ShapeToDelete = collisionShapes[local_shape_index]
