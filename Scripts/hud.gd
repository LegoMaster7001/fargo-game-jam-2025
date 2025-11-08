class_name HUD
extends Control

const TIME_FORMAT = "%.1f"

@export var player: Player
@export var enemy: Enemy

@export var role_label: Label
@export var time_label: Label
@export var scoreBox: TextEdit
@export var compass: Compass

func _ready() -> void:
	update_text()
	Global.role_changed.connect(_on_role_changed)

func _physics_process(delta: float) -> void:
	time_label.text = TIME_FORMAT % [Global.chase_timer.time_left]

func _on_role_changed(old: Global.role, current: Global.role, timeout: bool) -> void:
	if (Global.role.hunted == old && timeout):
		Global.addScore()
	elif (Global.role.hunted == old && !timeout):
		Global.subtractScore()
	elif (Global.role.hunter == old && timeout):
		Global.subtractScore()
	elif (Global.role.hunter == old && !timeout):
		Global.addScore()
	update_text()

func update_text():
	var text = "HUNT." if Global.player_is_hunter else "HIDE!"
	role_label.text = text
	scoreBox.text = ("Score " + str(Global.score))
