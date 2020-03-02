extends Spatial

export var Rotate_speed : float = 0.1
export var InfiniteRotation: bool = false
export var MaxRotationAngle = Vector3(10,45,0)
export var MinRotationAngle = Vector3(-10,-45,0)
export var CurrentRotationDegrees = Vector3(0,0,0) # (x,y,z)
export var XspaceAllowed: bool = false
#InfiniteRotation allows you to do 360 spins without it checking for a max angle.
#max angle is always 0 to a given number. and the CurrentRotationDegrees is the starting point of the scene.


func _ready() -> void:
	pass

func _physics_process(delta: float):
	movecamera(delta)
	

func movecamera(delta):
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_left") :
		pass

	elif Input.is_action_pressed("ui_right"):
		if (CurrentRotationDegrees.y > MaxRotationAngle.y):
			return
		CurrentRotationDegrees.y += Rotate_speed
		
	elif Input.is_action_pressed("ui_left"):
		if (CurrentRotationDegrees.y < MinRotationAngle.y):
			return
		CurrentRotationDegrees.y += -Rotate_speed

#The X axis
#	if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down") :
#		pass#velocity.z = SPEED
#	elif Input.is_action_pressed("move_up"):
#		pass#velocity.z = -SPEED
#		#$MeshInstance.rotate_x(deg2rad(-SPEED * 1.2))
#	elif Input.is_action_pressed("move_down"):
#		pass#velocity.z = SPEED
#		#$MeshInstance.rotate_x(deg2rad(SPEED * 1.2))
#	else:
#		pass#velocity.z = lerp(velocity.z,0,0.1)
