extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 4

func _ready() -> void:
	pass

func _physics_process(delta: float):
	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_left") :
		velocity.x = SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		
	if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down") :
		velocity.z = SPEED
	elif Input.is_action_pressed("move_up"):
		velocity.z = -SPEED
	elif Input.is_action_pressed("move_down"):
		velocity.z = SPEED
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	move_and_slide(velocity)