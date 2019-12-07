extends Actor


func _physics_process(delta: float) -> void: ## apparently, this also uses the Actor process alongside it. very cool.
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity)  # SET THIS https://www.youtube.com/watch?v=Mc13Z2gboEk&list=PLhqJJNjsQ7KH_z21S_XeXD3Ht3WnSqW97 1:00:00

	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0 # ternary opperator. its -1.0 if jump is pressed, else its just 1.0. very cool. ALSO NEEDS TO BE ON A FLOOR
	) # moving right is 1.0 while moving to the left is -1.0. allowing to move left or right.



func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2, 
		speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time() # delta is a vlue that checks the time between frames. very handy if you are laggy. etc.
	if direction.y == -1.0:
		velocity.y = speed.y * direction.y
	return new_velocity