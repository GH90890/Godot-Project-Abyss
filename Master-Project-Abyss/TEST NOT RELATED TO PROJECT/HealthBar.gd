extends Panel

signal health_depleted

onready var chunks = $chunks
onready var chunk = preload("Chunk.tscn")
onready var timer = $Timer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


func ready(health):
	rect_size.x = health * 3 + 3
	rect_size.y = 6
	
	rect_position.x = -(health * 3 + 3) / 2
	rect_position.y = 4
	
	for i in health:
		var c = chunk.instance()
		chunks.add_child(c)


func ping():
	show()
	timer.start()


func _on_Timer_timeout() -> void:
	hide()

func reduce_health(damage):
	ping()
	
	var health_current = chunks.get_children()
	var health_new = health_current.size() - damage
	
	for i in range (health_current.size() - 1, health_new - 1 , -1):
		if i >= 0:
			health_current[i].queue_free()
		if i <= 0:
			emit_signal("health_depleted")
