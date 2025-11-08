class_name ScoreKeeping
extends TextEdit

func _ready() -> void:
	update_score(0)

func update_score(score: int):
	text = ("Score: " + str(score))

func hit():
	if (Global.hunted):
		Global.addScore()
	else:
		Global.subtractScore()
	update_score(Global.score)
