extends Panel

var accum = 0
var current_value = 0

func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	current_value = $HSlider.value
	
func _on_Button_pressed():
	get_node("Label").text = "E!"
	
func _process(delta):
	accum += delta
	get_node("Counter").text = str(accum)
	if Input.is_action_just_released("Mouse_left"):
		if current_value != $HSlider.value:
			current_value = $HSlider.value
			$Blip.play()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
