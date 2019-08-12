extends MeshInstance

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_backward") || Input.is_action_pressed("move_forward"):
		self.queue_free()
	