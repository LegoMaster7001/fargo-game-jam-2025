class_name TagChecker
extends Node2D

@export var character_body_2d: CharacterBody2D
@export var debounce_timer: Timer
@export var opponent_collision_layer := 0

# must call AFTER move_and_slide
func is_colliding_with_opponent() -> bool:
	var collision_count := character_body_2d.get_slide_collision_count()
	for i in collision_count:
		var collision := character_body_2d.get_slide_collision(i)
		var collided_object := collision.get_collider()
		if not is_instance_of(collided_object, CollisionObject2D):
			continue
		if not collided_object.get_collision_layer_value(opponent_collision_layer):
			continue
		return true
	return false

# returns true if we were tagged
func try_tag() -> bool:
	if not can_be_tagged():
		return false
	debounce_timer.start()
	return true

func can_be_tagged() -> bool:
	return debounce_timer.is_stopped() and is_colliding_with_opponent()
