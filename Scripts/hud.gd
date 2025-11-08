class_name HUD
extends Control

@export var role_label: Label
@export var enemy: Enemy

func _ready() -> void:
	_on_role_changed(enemy.hunted)
	enemy.role_changed.connect(_on_role_changed)

func _on_role_changed(hunted: bool) -> void:
	# note this is the enemy's role
	var text = "HUNT." if hunted else "HIDE!"
	role_label.text = text
