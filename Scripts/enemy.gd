class_name Enemy
extends CharacterBody2D

var speed


@export var player: Node2D
@export var tag_checker: TagChecker
@export var role_flip_timer: Timer
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var initial_pos := global_position
@onready var rayDown = $Rays/Down
@onready var rayUp = $Rays/Up
@onready var rayLeft = $Rays/Left
@onready var rayRight = $Rays/Right
var stuckTimerIsRunning = false


func _ready() -> void:
	Global.role_changed.connect(_on_role_changed)

func _physics_process(delta: float) -> void:
	changeSpeed()
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	if tag_checker.try_tag():
		Global.addTime(false)
		Global.flip_role(false)
	
	changeSprites()

func makepath():
	nav_agent.target_position = player.global_position
	if (Global.player_is_hunter):
		nav_agent.target_position = to_global(-self.to_local(player.global_position))
		if (checkIfStuck()):
			nav_agent.target_position = Vector2(0, 0)

func _on_role_changed(old_role: Global.role, role: Global.role, timeout: bool) -> void:
	makepath()

func _on_timer_timeout():
	makepath()

func _on_hunt_area_body_exited(body: Node2D) -> void:
	if Global.player_is_hunter:
		return
	# the player has escaped, so now we become hunted
	print("{0} escaped".format([body.name]))
	Global.addTime(false)
	Global.flip_role(true)
	
func changeSprites():
	var SpriteFile = "res://Images/"
	if (Global.player_is_hunter):
		SpriteFile = SpriteFile + "EnemyRunAway/"
	else:
		SpriteFile = SpriteFile + "EnemyAngry/"
	match Global.score:
		1:
			$Sprite2D.texture = load(SpriteFile + "Enemy2.png")
		2:
			$Sprite2D.texture = load(SpriteFile + "Enemy3.png")
		3:
			$Sprite2D.texture = load(SpriteFile + "Enemy4.png")
		4:
			$Sprite2D.texture = load(SpriteFile + "Enemy5.png")
		_:
			$Sprite2D.texture = load(SpriteFile + "Enemy1.png")
		
		
func changeSpeed():
	match Global.score:
		1:
			speed = 70 
		2:
			speed = 80
		3:
			speed = 85
		4:
			speed = 95
		_:
			speed = 60
	if Global.player_is_hunted && Global.slow_timer.time_left > 0:
		speed *= 0.3

func checkIfStuck():
	if(!stuckTimerIsRunning):
		if (rayDown.is_colliding() || rayUp.is_colliding()):
			if (rayLeft.is_colliding() || rayRight.is_colliding()):
				$StuckTimer.start(1)
				stuckTimerIsRunning = true
				return true
		return false
	return true


func _on_stuck_timer_timeout() -> void:
	stuckTimerIsRunning = false
	
func getOverlappingBodies():
	return $Area2DTest.get_overlapping_bodies()
	
func getTagCooldownTimer():
	return tag_checker.debounce_timer.time_left
