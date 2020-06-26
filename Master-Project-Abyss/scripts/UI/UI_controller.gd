extends Control

var uiActive = true 
var uiState = true # true means the ui is inside the box.
var currentSeconds = 0
onready var uiTopRight = $"UI-TOP-RIGHT".margin_left
onready var uiTopLeft = $"UI-TOP-LEFT".margin_left
export var timeToHide = 10

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			currentSeconds = 0
	if Input.is_action_pressed("ui_accept"):
		$"Refracture/refracturePlayer".play("Shatter to normal")

func hideUI():
	if (uiActive == true):
		if uiState == false:
			$"UI-Animator".play("UI-move in")
			uiState = true
		pass
	
	if (uiActive == false):
		if uiState == true:
			$"UI-Animator".play("UI-move out")
			uiState = false

func _on_UIhidetimer_timeout() -> void:
	#adds a value per second. if that value is above timeToHide hide the UI.
	# but if mouse is moved. the seconds are set to 0 which sets the uiActive to true!
	## If I move then set it to 0, else add a number, -----------
	currentSeconds = currentSeconds+1
	
	if currentSeconds == timeToHide:
		uiActive = false
		hideUI()
		return
	if currentSeconds == 1:
		uiActive = true
		hideUI()
		return
