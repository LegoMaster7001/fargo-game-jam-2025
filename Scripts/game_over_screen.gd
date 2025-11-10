class_name GameOverScreen
extends Control

const WIN_TEXT := "(you [color=green]WON![/color])"
const LOSE_TEXT := "(you [color=red]LOST...[/color])"
var game_time = " seconds"

@export var overlay: ColorRect
@export var title: Control
@export var victory_label: RichTextLabel
@export var gametimelabel: Label

@onready var _title_initial_pos := title.position


func animate():
	var formatted_time = "%.3f" % Global.total_time
	gametimelabel.text = str(formatted_time) + " seconds"
	victory_label.text = WIN_TEXT if Global.score > 0 else LOSE_TEXT

	var tween = create_tween().set_parallel(true)

	tween.tween_method(set_mix_amount, 0.0, 0.8, 0.5)
	tween.tween_method(set_blur_amount, 0.0, 1, 0.5)

	var title_color := Color.GREEN if Global.score > 0 else Color.RED
	var title_start_pos := _title_initial_pos + Vector2(0, -get_viewport_rect().size.y)
	tween.tween_property(title, "position", _title_initial_pos, 0.3).from(title_start_pos)
	tween.tween_property(title, "modulate", title_color, 0.8).from(Color.TRANSPARENT)

	tween.tween_property(victory_label, "modulate", Color.WHITE, 0.8).from(Color.TRANSPARENT)

	tween.play()

# chopped but its chill
func set_blur_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("blur_amount", value)
func set_mix_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("mix_amount", value)
