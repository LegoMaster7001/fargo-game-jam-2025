extends Node2D

signal role_changed(hunted: bool)

var hunted = false
var score = 0
var scorekeeping = ScoreKeeping.new()

# "alias" for !hunted
var hunting: bool :
	get(): return !hunted

func flip_role():
	scorekeeping.hit()
	Global.hunted = !Global.hunted
	Global.role_changed.emit(Global.hunted)
	
func addScore():
	score += 1
	if (score == 5):
		get_tree().quit()
		
func subtractScore():
	score -= 1
	if (score == -5):
		get_tree().quit()
