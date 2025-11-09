class_name Player
extends CharacterBody2D

const speed = 100
const dashSpeed = 1.5

@export var groundies_area: Area2D
@export var dash_audio: AudioStreamPlayer
var dir : Vector2
var dashReady = true
var dashing = false

func _ready() -> void:
	assert(groundies_area !=  null, "Player: assign groundies area")
	_on_role_changed(Global.current_role, Global.current_role, false)
	Global.role_changed.connect(_on_role_changed)

func _physics_process(delta: float):
	velocity = dir * speed
	checkDashing()
	
	move_and_slide()

func _unhandled_input(event: InputEvent):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

	if event.is_action_pressed("call_groundies"):
		groundies_area.try_call_groundies()

	if event.is_action_pressed("debug_flip_role"):
		Global.flip_role(true)

func checkDashing():
	if (Input.is_key_pressed(KEY_E) && dashReady && Global.player_is_hunter):
		dashReady = false
		dashing = true
		$DashTimer.start()
		dash_audio.play()
	elif (Global.player_is_hunted):
		dashReady = true
		dashing = false
	if dashing:
		velocity = dir * speed * dashSpeed

func _on_dash_cooldown_timer_timeout() -> void:
	dashReady = true

func _on_dash_timer_timeout():
	dashing = false
	$DashCooldownTimer.start()
	
func changeSprites():
	if (Global.player_is_hunted):
		$Sprite2D.texture = load("res://Images/PlayerRunAway.png")
	else:
		$Sprite2D.texture = load("res://Images/PlayerAngry.png")

func _on_role_changed(old_role: Global.role, role: Global.role, timeout: bool) -> void:
	changeSprites()
	
func _get_cooldown_time():
	if (Global.player_is_hunter):
		return $DashCooldownTimer.time_left
	if (Global.player_is_hunted):
		return 
	return $DashCooldownTimer.time_left
