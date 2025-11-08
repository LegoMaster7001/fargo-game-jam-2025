extends CharacterBody2D

const speed = 100

@export var enemy: Enemy
@export var groundies_area: GroundiesArea
var dir : Vector2

func _physics_process(delta: float):
	velocity = dir * speed
	move_and_slide()
	
func _unhandled_input(event: InputEvent):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

	if event.is_action_pressed("action"):
		groundies_area.call_groundies()

	if event.is_action_pressed("debug_flip_role"):
		enemy.flip_role()
