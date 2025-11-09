class_name HUD
extends Control

const TIME_FORMAT = "%.1f"
var HIDE_TEXT_TEXTURE = ResourceLoader.load("res://Images/text/Hide_text_outlined.png")
var HUNT_TEXT_TEXTURE = ResourceLoader.load("res://Images/text/hunt_text_outlined.png")

@export var player: Player
@export var enemy: Enemy
@export var groundiesArea: GroundiesArea

@export var role_texture: TextureRect
@export var time_label: Label
@export var scoreBox: TextEdit
@export var compass: Compass
@export var pause_menu: PauseMenu
@export var game_over_screen: GameOverScreen
var isInArea = false
var hasEscaped = false

func _ready() -> void:
	update_text()
	update_compass_visibity()
	Global.role_changed.connect(_on_role_changed)
	groundiesArea.groundiesCalled.connect(_on_groundies_called)

func _physics_process(delta: float) -> void:
	time_label.text = TIME_FORMAT % [Global.chase_timer.time_left]
	var player_to_enemy := player.position.direction_to(enemy.position)
	compass.update_needle(player_to_enemy, delta)

func _on_groundies_called(isInAreaWhenGroundies):
	isInArea = isInAreaWhenGroundies
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_game()
	if event.is_action_pressed("debug_end_game"):
		end_game()

func pause_game():
	get_tree().paused = true
	pause_menu.show()
	pause_menu.audio.play()

func end_game():
	Global.game_over = true
	get_tree().paused = true
	hide()
	game_over_screen.show()
	game_over_screen.animate()

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

func _on_score_changed(score: int) -> void:
	if not Global.game_over:
		return
	end_game()

func update_compass_visibity():
	compass.visible = Global.player_is_hunter

func update_text():
	role_texture.texture = HUNT_TEXT_TEXTURE if Global.player_is_hunter else HIDE_TEXT_TEXTURE
	scoreBox.text = ("Score " + str(Global.score))
