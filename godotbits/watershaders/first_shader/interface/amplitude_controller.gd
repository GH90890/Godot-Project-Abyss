tool
extends VBoxContainer

signal amplitude_change(amplitude)

var amplitude = 10.0 setget set_amplitude
onready var label_start_text = $Label.text

func _on_Slider_value_changed(value: float) -> void:
	self.amplitude = value

func set_amplitude(value):
	amplitude = value
	$Label.text = label_start_text + " " + str(amplitude)
	emit_signal("amplitude_change", value)