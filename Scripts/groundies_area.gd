class_name GroundiesArea
extends Area2D

@export var enemy: Enemy
@export var grounded_audio: AudioStreamPlayer
@export var grounded_fail_audio: AudioStreamPlayer
@onready var collisionShapes = find_children("*", "CollisionShape2D")
@onready var meshes = find_children("*", "MeshInstance2D")

var ShapeToDelete : CollisionShape2D
var ShapeToAdd : MeshInstance2D
signal groundiesCalled(BodiesInArea)


func try_call_groundies() -> bool:
	if ($groundiesCooldownTimer.is_stopped()):
		$groundiesCooldownTimer.start()
		if not overlaps_body(enemy):
			groundiesCalled.emit(false)
			grounded_fail_audio.play()
			return false
		if Global.player_is_hunter:
			groundiesCalled.emit(false)
			return false
		grounded_audio.play()
		Global.flip_role(true)
		groundiesCalled.emit(true)
		
		ShapeToAdd.modulate.a = 0.5
		ShapeToDelete.queue_free()
		collisionShapes.erase(ShapeToDelete)
		meshes.erase(ShapeToAdd)
		return true
	groundiesCalled.emit(false)
	return false

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		ShapeToDelete = collisionShapes[local_shape_index]
		ShapeToAdd = meshes[local_shape_index]

func _get_cooldown_timer():
	return $groundiesCooldownTimer
