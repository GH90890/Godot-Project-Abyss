extends Node

func _ready() -> void:
	# Get config file,
	# set config file's inputs in here, and update it.
	var display = get_node("Procentage_Display")
	display.text = (str($"SFX Slider".value))

	
func _process(delta: float) -> void:
	var display = get_node("Procentage_Display")
	var SFXtest = get_node("Soundtest")
	var sfx_number
	var check_if_play_sound = $"SFX Slider".value
	
	display.text = (str(check_if_play_sound))
	if (Input.is_action_just_pressed("mouse_left")):
		sfx_number = $"SFX Slider".value
		print("Left button clicked : " , sfx_number)
	if (Input.is_action_just_released("mouse_left")):
		if (sfx_number != $"SFX Slider".value):
			SFXtest.volume_db = (check_if_play_sound - 100)
			SFXtest.play()