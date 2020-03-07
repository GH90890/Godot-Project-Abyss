extends Spatial

#This script is only per scene, dont add this to main layers
onready var CameraStand = get_node(".")
export var Rotate_speed : float = 0.4
export var InfiniteRotation: bool = false
export var MaxRotationAngle = Vector3(5,25,0)
export var MinRotationAngle = Vector3(-5,-25,0)
export var CurrentRotationDegrees = Vector3(0,0,0) # (x,y,z)
export var XspaceAllowed: bool = false
#InfiniteRotation allows you to do 360 spins without it checking for a max angle.
#max angle is always 0 to a given number. and the CurrentRotationDegrees is the starting point of the scene.


func _ready() -> void:
	pass

func _physics_process(delta: float):
	moveCamera(delta)
	CameraStand.set_rotation_degrees(CurrentRotationDegrees)

func moveCamera(delta):
	# if its 360 degrees make it 0
	if (int(CurrentRotationDegrees.y) >= 720):
		CurrentRotationDegrees.y = 0	
	#if its -degrees make it 0!
	if (int(CurrentRotationDegrees.y) <= -720):
		CurrentRotationDegrees.y = 0
	
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_left") :
		return

	elif Input.is_action_pressed("ui_right"):
		rotateRight()


	elif Input.is_action_pressed("ui_left"):
		rotateLeft()

	#x access

	if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_down") :
		return

	elif Input.is_action_pressed("ui_up"):
		rotateUp()

	elif Input.is_action_pressed("ui_down"):
		rotateDown()


func rotateRight():
	if (CurrentRotationDegrees.y > MaxRotationAngle.y):
		if (InfiniteRotation != true):
			return
	CurrentRotationDegrees.y += Rotate_speed
	
func rotateLeft():
	if (CurrentRotationDegrees.y < MinRotationAngle.y):
			if (InfiniteRotation != true):
				return
	CurrentRotationDegrees.y -= Rotate_speed

func rotateUp():
	if (CurrentRotationDegrees.x > MaxRotationAngle.x) && (XspaceAllowed == true):
		return
	CurrentRotationDegrees.x += (Rotate_speed / 2)

func rotateDown():
	if (CurrentRotationDegrees.x < MinRotationAngle.x) && (XspaceAllowed == true):
		return
	CurrentRotationDegrees.x -= (Rotate_speed / 2)
