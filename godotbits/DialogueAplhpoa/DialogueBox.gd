# DialogBox.gd
extends RichTextLabel

# Variables
var dialog = [
	"Hey! This is a texty boy.",
	"Whoa, Actual dialogue scrolling!",
	"soo this is a [color=red]red[/color] boy!"]
var page = 0

# Functions
func _ready():
	set_process_input(true)
	set_bbcode(dialog[page])
	set_visible_characters(0)

func _on_Button_pressed() -> void:
	if (true):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	if(self.visible_characters < 500): # avoids infinite characters that end up blowing up the int value.
		set_visible_characters(get_visible_characters()+1)


