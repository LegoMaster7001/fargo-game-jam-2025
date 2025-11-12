extends HSlider


@export var bus_name := "Master"

@onready var bus_idx := AudioServer.get_bus_index(bus_name)


func _ready() -> void:
	value = AudioServer.get_bus_volume_linear(bus_idx)
	_on_value_changed(value)
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(new_value))
