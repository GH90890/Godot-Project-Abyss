extends Spatial

func _process(delta: float) -> void:
	global_transform.basis = get_node("../Player/Head/Camera").global_transform.basis
	rotation.x = 0
#global_transform is the entire transform in the world -- includes scale, rotation, translation.
