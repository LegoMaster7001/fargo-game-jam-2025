extends Node2D

const GAME_OVER_SCORE_THRESHOLD := 5
const CHASE_DURATION := 10
const SLOW_DURATION := 0.5

signal role_changed(old_role: role, role: role, timeout: bool)
signal score_changed(score: int)

enum role {hunter, hunted}
var current_role = role.hunted
var score: int = 0 :
	set(value):
		score = value
		score_changed.emit(value)

var game_over := false
var should_game_over: bool :
	get(): return abs(score) >= GAME_OVER_SCORE_THRESHOLD

var player_is_hunted: bool :
	get(): return current_role == role.hunted

var player_is_hunter: bool :
	get(): return current_role == role.hunter

var chase_timer := Timer.new()
var slow_timer := Timer.new()

var total_time: float = 0

func _ready() -> void:
	chase_timer.wait_time = CHASE_DURATION
	chase_timer.timeout.connect(_on_timeout)
	add_child(chase_timer)
	
func addTime(timeout: bool):
	if (timeout):
		total_time += 10
	elif (!timeout):
		total_time += 10 - chase_timer.time_left

	slow_timer.wait_time = SLOW_DURATION
	slow_timer.one_shot = true
	add_child(slow_timer)

func flip_role(timeout: bool):
	if not timeout:
		slow_timer.start()
	chase_timer.start()
	var temp = current_role
	current_role = (current_role + 1) % role.size()
	Global.role_changed.emit(temp, Global.current_role, timeout)
	
func addScore():
	score += 1
		
func subtractScore():
	score -= 1

func _on_timeout() -> void:
	Global.addTime(true)
	Global.flip_role(true)

func restart():
	MusicPlayer.stream = MusicPlayer.DEFAULT_MUSIC
	MusicPlayer.play()
	current_role = role.hunted
	score = -1
	game_over = false
	total_time = 0
