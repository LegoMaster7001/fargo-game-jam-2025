class_name HUD
extends Control

const TIME_FORMAT = "%.1f"

@export var player: Player
@export var enemy: Enemy

@export var role_label: Label
@export var time_label: Label
@export var compass: Compass

func _ready() -> void:
	_on_role_changed(Global.hunted)
	Global.role_changed.connect(_on_role_changed)

func _physics_process(delta: float) -> void:
	time_label.text = TIME_FORMAT % [Global.chase_timer.time_left]

func _process(delta: float) -> void:
	compass.update_needle((enemy.position-player.position).normalized(), delta)

func _on_role_changed(hunted: bool) -> void:
	# note this is the enemy's role
	var text = "HUNT." if hunted else "HIDE!"
	role_label.text = text
	compass.visible = hunted
