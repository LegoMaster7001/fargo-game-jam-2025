extends CharacterBody2D

const speed = 100
const dashSpeed = 2
var dir : Vector2
var dashReady = true
var dashing = false

func _physics_process(delta: float):
	velocity = dir * speed
	checkDashing()
	
	move_and_slide()
	
func _unhandled_input(event: InputEvent):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

func checkDashing():
	if Input.is_key_pressed(KEY_E) && dashReady:
		dashReady = false
		dashing = true
		$DashTimer.start()
	if dashing:
		velocity = dir * speed * dashSpeed



func _on_dash_cooldown_timer_timeout() -> void:
	dashReady = true


func _on_dash_timer_timeout():
	dashing = false
	$DashCooldownTimer.start()
