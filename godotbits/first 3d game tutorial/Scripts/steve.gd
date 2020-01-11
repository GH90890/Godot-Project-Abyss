extends KinematicBody


var velocity = Vector3(0,0,0)
const SPEED = 6

func _ready() -> void:
	pass

func _physics_process(delta: float):
	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_left") :
		velocity.x = SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		$MeshInstance.rotate_z(deg2rad(-SPEED * 1.2))
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		$MeshInstance.rotate_z(deg2rad(SPEED * 1.2))
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		
	if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down") :
		velocity.z = SPEED
	elif Input.is_action_pressed("move_up"):
		velocity.z = -SPEED
		$MeshInstance.rotate_x(deg2rad(-SPEED * 1.2))
	elif Input.is_action_pressed("move_down"):
		velocity.z = SPEED
		$MeshInstance.rotate_x(deg2rad(SPEED * 1.2))
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	move_and_slide(velocity)