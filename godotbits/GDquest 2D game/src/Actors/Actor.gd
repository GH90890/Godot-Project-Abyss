extends KinematicBody2D
class_name Actor # makes it so we can extend it! ^look up but then with Actor



const FLOOR_NORMAL = Vector2.UP #UP = (0,-1)

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 4000.0  # this is a float value.

var _velocity: = Vector2.ZERO # hey godot this is a vector 2
