extends RichTextLabel
signal text_finished

var dialog_finished = false
var scroll_speed = 100 # 0.3 is normal 0.01 is fast. maybe set the + cgharacter count to 3 to get the highest
var scroll_skip = 1


func _process(delta: float) -> void:
	get_input()

func get_input():
	if Input.is_action_just_released("ui_accept")&&(dialog_finished == false):
		dialog_skip()
	elif Input.is_action_just_released("ui_accept"):
		dialog_start()

func _ready() -> void:
	set_visible_characters(0);
	$"Scroll_Timer".wait_time = (scroll_speed / 1000)
	

func _on_Timer_timeout():
	if(self.visible_characters < get_total_character_count()+1): # avoids infinite characters that end up blowing up the int value.
		set_visible_characters(get_visible_characters() + scroll_skip)
	elif(dialog_finished == false):
		dialog_end()

func dialog_start(): #fired when the player loads in a new dialog
	dialog_finished = false
	$"Scroll_Timer".start
	set_visible_characters(0);

func dialog_skip(): #checks if the text is running, and ends the text scrolling
	set_visible_characters(255); #maybe set it higher? or check text size itself.
	dialog_end()

func dialog_end(): #fires when the dialogue ends.
	dialog_finished = true
	$"Scroll_Timer".stop
	emit_signal("text_finished")
	


#Add in a check that sees if the other script is finished..? maybe if animation player is finished.
# no player animation. make a function that fires when the timer is finished.
