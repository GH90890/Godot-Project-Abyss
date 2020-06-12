extends Control

onready var musicPlayer = $"../musicVisualiserGraphics/AudioStreamPlayer"
onready var textLabel = $"ColorRect/first music text"
onready var textLabel2 = $"ColorRect/second music text"
var scrollSpeed = 100
var cutOff = 250

var toggle_which_text = false

func _process(delta: float):
	textLabel.margin_left -= scrollSpeed * delta
	textLabel2.margin_left -= scrollSpeed * delta
	
	if toggle_which_text == true : # lable 1 is moving 
		
		if textLabel.margin_left <= -cutOff +150 : #Once I am past the point, set me back.
			textLabel2.margin_left = $"ColorRect".margin_right
			toggle_which_text = !toggle_which_text

	if toggle_which_text == false :# label 2 is moving.
		
		if textLabel2.margin_left <= -cutOff +150 : #Once I am past the point, set me back.
			textLabel.margin_left = $"ColorRect".margin_right
			toggle_which_text = !toggle_which_text
	
func _ready() -> void:
	setLabelText(getCurrentMusic())
	

func setLabelText(inputText):
	textLabel.rect_size.x = 3 # it needs to be small so it can be filled up once more.
	textLabel2.rect_size.x = 3 # ditto ^
	#sets the text to whatever.
	textLabel.text = inputText
	textLabel2.text = inputText
	updateTextSize()
	$"ColorRect/Timer".start()


func getCurrentMusic():
	# gets the current music playing, from the audio stream.
	return musicPlayer.stream.resource_path.get_file().replace(".ogg", "")

func updateTextSize():
	cutOff = textLabel.rect_size.x
	print("cut off size is now:")
	print(cutOff)



func _on_Timer_timeout() -> void:
	updateTextSize()
