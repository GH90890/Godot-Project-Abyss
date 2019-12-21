extends Actor


export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	queue_free() # player fucking dies .jpeg


func _physics_process(delta: float) -> void: ## apparently, this also uses the Actor process alongside it. very cool.
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0 # when jumping the _velocity is in a minus state. meaning its going up!
	var direction: = get_direction() ## this is scoped.
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) 

	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0 # ternary opperator. its -1.0 if jump is pressed, else its just 1.0. very cool. ALSO NEEDS TO BE ON A FLOOR
	) # moving right is 1.0 while moving to the left is -1.0. allowing to move left or right.


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2, 
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time() # delta is a vlue that checks the time between frames. very handy if you are laggy. etc.
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted: # if its true.
		out.y = 0.0
	return out

func calculate_stomp_velocity(
	linear_velocity: Vector2,
	impulse: float ) -> Vector2:
		var out = linear_velocity
		out.y = -impulse
		return out


