extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

#fly variables
const FLY_SPEED = 20
const FLY_ACCEL = 4
var flying = false

#walk variables
var gravity = -9.8 * 3
const MAX_SPEED = 10
const MAX_RUNNING_SPEED = 15
const ACCEL = 20
const DEACCEL = 60

#jumping
var in_air = 0
var has_contact = false

#slope variables
const MAX_SLOPE_ANGLE = 35

#stair variables
const MAX_STAIR_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	aim()
	walk(delta)

func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative
		
func walk(delta):
	# reset the direction of the player
	direction = Vector3()
	
	# get the rotation of the camera
	var aim = $Head/Camera.get_global_transform().basis
	# check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	direction.y = 0
	direction = direction.normalized()
	
	if (is_on_floor()):
		has_contact = true
		var n = $Tail.get_collision_normal()
		var floor_angle = rad2deg(acos(n.dot(Vector3(0, 1, 0))))
		if floor_angle > MAX_SLOPE_ANGLE:
			velocity.y += gravity * delta
		
	else:
		if !$Tail.is_colliding():
			has_contact = false
		
		velocity.y += gravity * delta
		#velocity.y = -1

	if (has_contact and !is_on_floor()):
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_forward"):
			move_and_collide(Vector3(0, -1, 0))

	
	if (direction.length() > 0 and $StairCatcher.is_colliding()):
		var stair_normal = $StairCatcher.get_collision_normal()
		var stair_angle = rad2deg(acos(stair_normal.dot(Vector3(0, 1, 0))))
		if stair_angle < MAX_STAIR_SLOPE:
			velocity.y = STAIR_JUMP_HEIGHT
			has_contact = false
	
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_RUNNING_SPEED
	else:
		speed = MAX_SPEED
	
	
	# where would the player go at max speed
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
	
	# calculate a portion of the distance to go
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	# move
	velocity = move_and_slide_with_snap(velocity, Vector3(0, -1, 0), Vector3(0, 1, 0), true, 4, deg2rad(45), false)
	
	if !has_contact:
		#print(in_air)
		in_air += 1
		
	$StairCatcher.translation.x = direction.x
	$StairCatcher.translation.z = direction.z
	
func aim():
	if camera_change.length() > 0:
		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))

		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 60 and change + camera_angle > -60:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
		camera_change = Vector2()


func _on_Area_body_entered( body ):
	if body.name == "Player":
		flying = true


func _on_Area_body_exited( body ):
	if body.name == "Player":
		flying = false


#================================================ PLAYER STOPPER FOR Y AXIS
#const yStopper = preload ("res://PreFab/Ymovementstopper.tscn")
#var yMovementStopper = yStopper.instance()
#var ownBodyLocation = self.translation
#var boolPlatform = false
# if movement stops spawn platform at x.y.z from this node.
# if movement is pressed, it destroys itself (code in the ymovement object self?)
#
#
#func _process(delta: float) -> void:
#	if !Input.is_action_pressed("move_left") || !Input.is_action_pressed("move_right") || !Input.is_action_pressed("move_backward") || !Input.is_action_pressed("move_forward"):
#	#spawn the thing ymovement stopper
#		if boolPlatform == false:
#			get_parent().add_child(yMovementStopper)
#			boolPlatform = true
#			
#	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_forward"):
#		if boolPlatform == true:
#			boolPlatform = false
#
