class_name GameOverScreen
extends Control

@export var overlay: ColorRect

func animate():
	var tween = create_tween().set_parallel(true)
	tween.tween_method(set_mix_amount, 0.0, 0.8, 0.2)
	tween.tween_method(set_blur_amount, 0.0, 1, 0.2)
	tween.play()

# chopped but its chill
func set_blur_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("blur_amount", value)
func set_mix_amount(value: float) -> void:
	(overlay.material as ShaderMaterial).set_shader_parameter("mix_amount", value)
