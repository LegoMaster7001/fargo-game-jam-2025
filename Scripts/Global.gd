extends Node2D

const CHASE_DURATION := 10

signal role_changed(hunted: bool)

var hunted = false
# "alias" for !hunted
var hunting: bool :
	get(): return !hunted

var chase_timer := Timer.new()

func _ready() -> void:
	chase_timer.wait_time = CHASE_DURATION
	chase_timer.autostart = true
	chase_timer.timeout.connect(_on_timeout)
	add_child(chase_timer)

func flip_role():
	Global.hunted = !Global.hunted
	Global.role_changed.emit(Global.hunted)

func _on_timeout() -> void:
	# TODO: deduct a point
	Global.flip_role()
