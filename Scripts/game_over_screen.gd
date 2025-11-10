class_name GameOverScreen
extends Control

const WIN_TEXT := "(you [color=green]WON![/color])"
const LOSE_TEXT := "(you [color=red]LOST...[/color])"
var game_time = " seconds"

@export var overlay: ColorRect
@export var title: Control
@export var victory_label: RichTextLabel
@export var gametimelabel: Label
@export var input_help: Label

@onready var _input_init_pos := input_help.position
@onready var _title_initial_pos := title.position

func do_game_over_stuff():
	var formatted_time = "%.3f" % Global.total_time
	gametimelabel.text = str(formatted_time) + " seconds"
	var won = Global.score > 0
	MusicPlayer.stream = MusicPlayer.WIN_MUSIC if won else MusicPlayer.LOSS_MUSIC
	MusicPlayer.play()
	victory_label.text = WIN_TEXT if won else LOSE_TEXT

	var tween = create_tween().set_parallel(true)

	tween.tween_method(set_mix_amount, 0.0, 0.8, 0.5)
	tween.tween_method(set_blur_amount, 0.0, 1, 0.5)

	var title_color := Color.GREEN if won else Color.RED
	var title_start_pos := _title_initial_pos + Vector2(0, -get_viewport_rect().size.y)
	tween.tween_property(title, "position", _title_initial_pos, 0.3).from(title_start_pos)
	tween.tween_property(title, "modulate", title_color, 0.8).from(Color.TRANSPARENT)

	tween.tween_property(victory_label, "modulate", Color.WHITE, 0.8).from(Color.TRANSPARENT)

	var input_start := _input_init_pos + Vector2(0, get_viewport_rect().size.y)
	input_help.position = input_start
	tween.tween_property(input_help, "position", _input_init_pos, 0.3).from(input_start).set_delay(0.5)

	tween.play()

# chopped but its chill
func set_blur_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("blur_amount", value)
func set_mix_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("mix_amount", value)
