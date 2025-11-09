extends Node

const GAME_SCENE_PATH := "res://Scenes/Game.tscn"

func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_pressed():
		return
	SceneSwitcher.goto_scene(GAME_SCENE_PATH)
