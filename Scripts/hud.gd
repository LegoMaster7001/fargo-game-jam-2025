class_name HUD
extends Control

const TIME_FORMAT = "%.1f"

@export var player: Player
@export var enemy: Enemy
@export var groundiesArea: GroundiesArea

@export var role_label: Label
@export var time_label: Label
@export var scoreBox: TextEdit
@export var compass: Compass
var isInArea = false

func _ready() -> void:
	update_text()
	update_compass_visibity()
	Global.role_changed.connect(_on_role_changed)
	groundiesArea.groundiesCalled.connect(_on_groundies_called)

func _physics_process(delta: float) -> void:
	time_label.text = TIME_FORMAT % [Global.chase_timer.time_left]
	var player_to_enemy := player.position.direction_to(enemy.position)
	compass.update_needle(player_to_enemy, delta)

func _on_groundies_called(isThereSomethingInArea):
	isInArea = isThereSomethingInArea
	

func _on_role_changed(old: Global.role, current: Global.role, timeout: bool) -> void:
	if (Global.role.hunted == old && timeout):
		Global.addScore()
	elif (Global.role.hunted == old && !timeout):
		Global.subtractScore()
	elif (Global.role.hunter == old && !timeout):
		Global.addScore()
	elif (isInArea):
		Global.addScore()
	elif (Global.role.hunter == old && timeout):
		Global.subtractScore()
	update_text()
	update_compass_visibity()

func update_compass_visibity():
	compass.visible = Global.player_is_hunter

func update_text():
	var text = "HUNT." if Global.player_is_hunter else "HIDE!"
	role_label.text = text
	scoreBox.text = ("Score " + str(Global.score))
