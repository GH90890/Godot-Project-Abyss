extends TextureRect

onready var amplitude = material.get_shader_param("amplitude")

func _ready():
	print(amplitude)
	#assert amplitude != null

func _on_AmplitudeController_amplitude_change(value):
	amplitude.x = value
	material.set_shader_param("amplitude", amplitude)
	print(amplitude)