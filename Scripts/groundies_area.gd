class_name GroundiesArea
extends Area2D

@export var enemy: Enemy
@onready var collisionShapes = find_children("*", "CollisionShape2D")
@onready var meshes = find_children("*", "MeshInstance2D")

var ShapeToDelete : CollisionShape2D
var ShapeToAdd : MeshInstance2D
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
	var mesh = MeshInstance2D.new()
	
	var mesh2d = ShapeToDelete.get_child(0)
	mesh2d.modulate.a = 0.5
	ShapeToDelete.queue_free()
	collisionShapes.erase(ShapeToDelete)
	return true
	

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		ShapeToDelete = collisionShapes[local_shape_index]
		meshes = collisionShapes[local_shape_index]
