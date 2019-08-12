extends CSGBox
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target = Vector3()

func _ready() -> void: # could be used when guy enters a scene, so no _process thing gets activated
	target = get_node("../Player").translation # gets the players x,y,z position.
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _process(delta: float) -> void:
	
	target = get_node("../Player").translation # gets the players x,y,z position.
	look_at(target, Vector3(0,1,0)) #target is the pos.player and vector3 is the direction the object itself is looking
