extends NinePatchRect

signal clicked(slot)

onready var _Button = $Button

var slot
var is_focus : bool = false


func _on_Button_pressed() -> void:
	emit_signal("clicked", slot)


func set_text(new_text : String):
	_Button.text = new_text

func focus():
	self.patch_margin_left - 3
