extends Node

var check_if_play_sound = 0
var sfx_number = 0

func _ready() -> void:
	# Get config file,
	# set config file's inputs in here, and update it.
	var display = get_node("SFX Slider/Procentage_Display")
	display.text = (str($"SFX Slider".value))

	
func _process(delta: float) -> void:
	var display = get_node("SFX Slider/Procentage_Display")
	var SFXtest = get_node("SFX Slider/Soundtest")
	check_if_play_sound = $"SFX Slider".value
	
	display.text = (str(check_if_play_sound))
	
	if (Input.is_action_just_pressed("mouse_left")):
		sfx_number = $"SFX Slider".value
		print("Left button clicked : " , sfx_number)
		
	if (Input.is_action_just_released("mouse_left")):
		var sfx_number_release = $"SFX Slider".value
		print("Left button released : " , sfx_number_release)
		if (sfx_number != sfx_number_release):
			SFXtest.volume_db = (-100 +(check_if_play_sound * 10))
			print("SOUND PLAYED AT DB OF : " , SFXtest.volume_db)
			SFXtest.play()