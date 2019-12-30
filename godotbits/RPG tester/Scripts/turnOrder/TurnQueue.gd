extends Node

class_name TurnQueue # this is a class, can be accessed?

var active_character

func initialize():
	active_character = get_child(0)
	
func play_turn():
	yield(active_character.play_turn(), "completed") # wait untill this is finished!
	var new_index : int =  (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)