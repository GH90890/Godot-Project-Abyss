extends RayCast

func use_weapon():
	$RayCast.force_raycast_update()

	if !$RayCast.is_colliding():
		return

	var collider = $RayCast.get_collider()
	if collider.has_method("damage"): #checks if whatever has a method?
		collider.damage(10)