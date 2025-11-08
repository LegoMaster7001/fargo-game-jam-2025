class_name Enemy
extends CharacterBody2D

const speed = 20

@export var player: Node2D
@export var role_flip_timer: Timer
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var initial_pos := global_position


func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
	changeSprites()

func makepath():
	nav_agent.target_position = player.global_position
	if (Global.hunted):
		nav_agent.target_position = -player.global_position

func flip_role():
	Global.hunted = !Global.hunted
	makepath()
	role_flip_timer.start()

func _on_timer_timeout():
	makepath()

func _on_timer_2_timeout() -> void:
	flip_role()
	
func changeSprites():
	if (Global.hunted):
		$Sprite2D.texture = load("res://Images/EnemyRunAway.png")
	else:
		$Sprite2D.texture = load("res://Images/EnemyAngry.png")
