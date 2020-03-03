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
	movecamera(delta)
	CameraStand.set_rotation_degrees(CurrentRotationDegrees)
	print(CurrentRotationDegrees.y)

func movecamera(delta):
	# if its 360 degrees make it 0
	if (int(CurrentRotationDegrees.y) >= 720):
		CurrentRotationDegrees.y = 0	
	#if its -degrees make it 0!
	if (int(CurrentRotationDegrees.y) <= -720):
		CurrentRotationDegrees.y = 0
	
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_left") :
		return

	elif Input.is_action_pressed("ui_right"):
		if (CurrentRotationDegrees.y > MaxRotationAngle.y):
			if (InfiniteRotation != true):
				return
		CurrentRotationDegrees.y += Rotate_speed

	elif Input.is_action_pressed("ui_left"):
		if (CurrentRotationDegrees.y < MinRotationAngle.y):
			if (InfiniteRotation != true):
				return
		CurrentRotationDegrees.y -= Rotate_speed

	#x access
	if XspaceAllowed == true:
		if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_down") :
			return

		elif Input.is_action_pressed("ui_up"):
			if (CurrentRotationDegrees.x > MaxRotationAngle.x):
				return
			CurrentRotationDegrees.x += (Rotate_speed / 2)

		elif Input.is_action_pressed("ui_down"):
			if (CurrentRotationDegrees.x < MinRotationAngle.x):
				return
			CurrentRotationDegrees.x -= (Rotate_speed / 2)
