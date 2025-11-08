extends CharacterBody2D

const speed = 100
const dashSpeed = 2

@export var groundies_area: GroundiesArea
var dir : Vector2
var dashReady = true
var dashing = false

func _ready() -> void:
	assert(groundies_area !=  null, "Player: assign groundies area")

func _physics_process(delta: float):
	velocity = dir * speed
	checkDashing()
	
	move_and_slide()
	changeSprites()

func _unhandled_input(event: InputEvent):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

	if event.is_action_pressed("call_groundies"):
		groundies_area.try_call_groundies()

	if event.is_action_pressed("debug_flip_role"):
		groundies_area.enemy.flip_role()

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
	
func changeSprites():
	if (!Global.hunted):
		$Sprite2D.texture = load("res://Images/PlayerRunAway.png")
	else:
		$Sprite2D.texture = load("res://Images/PlayerAngry.png")
