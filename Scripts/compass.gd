class_name Compass
extends Control

const LERP_WEIGHT := 0.4

func update_needle(player_to_enemy: Vector2, delta: float) -> void:
	var goal_rotation = atan2(player_to_enemy.y, player_to_enemy.x) + (PI/2)
	# rotation = goal_rotation
	rotation = lerp_angle(rotation, goal_rotation, 1-pow(LERP_WEIGHT, delta))
