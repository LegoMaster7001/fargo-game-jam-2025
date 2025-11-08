extends CharacterBody2D

const speed = 20

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var test = true

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	if (test):
		$Sprite2D.modulate = Color(0, 1, 0)
	else:
		$Sprite2D.modulate = Color(1, 0, 0)

func makepath():
	nav_agent.target_position = player.global_position
	if (test):
		nav_agent.target_position = -player.global_position


func _on_timer_timeout():
	makepath()


func _on_timer_2_timeout() -> void:
	test = !test

func _on_tag_zone_body_entered(body: Node2D) -> void:
	print(body)
	if(test):
		print("You tagged me!")
	else:
		print("I tagged you!")
