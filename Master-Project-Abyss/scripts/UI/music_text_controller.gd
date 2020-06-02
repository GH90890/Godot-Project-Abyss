extends Control

onready var musicPlayer = $"../musicVisualiserGraphics/AudioStreamPlayer"
onready var textLabel = $"ColorRect/Label"
var scrollSpeed = 260
var cutOff = 101

func _process(delta: float):
	textLabel.rect_position.x -= scrollSpeed * delta
	if textLabel.rect_position.x <= -478 :
		print(textLabel.rect_position.x)
		textLabel.rect_position.x += 440*2
	
func _ready() -> void:
	print(getCurrentMusic())
	setLabelText(getCurrentMusic())
	updateTextSize()

func setLabelText(inputText):
	#sets the text to whatever.
	textLabel.text = inputText


func getCurrentMusic():
	# gets the current music playing, from the audio stream.
	return musicPlayer.stream.resource_path.get_file().replace(".ogg", "")

func updateTextSize():
	cutOff = textLabel.rect_size.x
	print(cutOff)
