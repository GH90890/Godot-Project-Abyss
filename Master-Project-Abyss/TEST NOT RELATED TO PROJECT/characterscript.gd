extends KinematicBody2D

const HEALTH_MAX = 25

onready var healthBar = $"HealthBar"

func _ready() -> void:
	healthBar.ready(HEALTH_MAX) # this connects to the other script.


func _physics_process(_delta):
	get_input()

func get_input():
	if Input.is_action_just_released("ui_accept"):
		healthBar.reduce_health(1)
	if Input.is_action_pressed("ui_cancel"):
		healthBar.ping()


func _on_HealthBar_health_depleted() -> void:
	queue_free()
