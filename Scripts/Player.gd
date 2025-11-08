extends CharacterBody2D

const speed = 100

@export var groundies_area: GroundiesArea
var dir : Vector2

func _ready() -> void:
	assert(groundies_area !=  null, "Player: assign groundies area")

func _physics_process(delta: float):
	velocity = dir * speed
	move_and_slide()
	
func _unhandled_input(event: InputEvent):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

	if event.is_action_pressed("call_groundies"):
		print("hello")
		groundies_area.try_call_groundies()

	if event.is_action_pressed("debug_flip_role"):
		groundies_area.enemy.flip_role()
