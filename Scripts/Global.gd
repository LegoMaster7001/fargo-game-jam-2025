extends Node2D

const CHASE_DURATION := 10

signal role_changed(old_role: role, role: role, timeout: bool)

enum role {hunter, hunted}
var current_role = role.hunted
var score = 0

var player_is_hunted: bool :
	get(): return current_role == role.hunted

var player_is_hunter: bool :
	get(): return current_role == role.hunter

var chase_timer := Timer.new()

func _ready() -> void:
	chase_timer.wait_time = CHASE_DURATION
	chase_timer.timeout.connect(_on_timeout)
	add_child(chase_timer)

func flip_role(timeout: bool):
	chase_timer.start()
	var temp = current_role
	current_role = (current_role + 1) % role.size()
	Global.role_changed.emit(temp, Global.current_role, timeout)
	
func addScore():
	score += 1
	if (score == 5):
		get_tree().quit()
		
func subtractScore():
	score -= 1
	if (score == -5):
		get_tree().quit()

func _on_timeout() -> void:
	# TODO: deduct a point
	Global.flip_role(true)
