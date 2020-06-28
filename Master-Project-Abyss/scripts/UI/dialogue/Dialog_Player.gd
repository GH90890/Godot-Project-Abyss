extends Node

onready var _Body_Label = find_node("Body_Label")
onready var _Dialog_Box = find_node("Dialog_Box")
onready var _Speaker_Label = find_node("Speaker_Label")
onready var _Continue_Icon = find_node("Continue_Icon")
#onready var _Timer = find_node("Scroll_Timer")
onready var _Body_AnimationPlayer = find_node("Body_player")


var _did = 0 # Current ID
var _nid = 0 # Current node ID
var _final_nid = 0 # The final node.
var _Story_Reader #reference to the story file.

#virtual methods

func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	_Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://dialog/demo/baked/test_story.tres")
	_Story_Reader.read(story)

	_Dialog_Box.visible = false
	_Continue_Icon.visible = false

	play_dialog("Demo/Test")


func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and event.pressed == true:
			_on_Dialog_Player_pressed_Spacebar()

#callback methods
#func _process(delta: float) -> void:
#	get_input()

#func get_input():
#	if Input.is_action_just_released("ui_accept")&&(_Body_Label.dialog_finished == false):
#		_Body_Label.dialog_skip()
#	elif Input.is_action_just_released("ui_accept"):
#		_Body_Label.dialog_start()

func _on_Dialog_Player_pressed_Spacebar():
	if _is_waiting():
		_Continue_Icon.visible = false
		_get_next_node()
		if _is_playing():
			_play_node()
			

func _on_Body_player_animation_finished(anim_name: String) -> void:
	_Continue_Icon.visible = true


#func _on_Body_Label_text_finished() -> void:
#	_Continue_Icon.visible = true

#public methods

func play_dialog(record_name : String):
	_did = _Story_Reader.get_did_via_record_name(record_name)
	_nid = _Story_Reader.get_nid_via_exact_text(_did, "<start>")
	_final_nid = _Story_Reader.get_nid_via_exact_text(_did, "<end>")
	_get_next_node()
	_play_node()
	_Dialog_Box.visible = true
#private methods

func _is_playing() -> bool:
	return _Dialog_Box.visible

func _is_waiting() -> bool:
	return _Continue_Icon.visible

func _get_next_node():
	_nid = _Story_Reader.get_nid_from_slot(_did, _nid, 0)
	
	if _nid == _final_nid: # Am I at the end? finish the dialog_box.
		_Dialog_Box.visible = false

func _get_tagged_text(tag : String, text : String):
	var start_tag = "<" + tag + ">"
	var end_tag = "</" + tag + ">"
	var start_index = text.find(start_tag) + start_tag.length()
	var end_index = text.find(end_tag)
	var substr_length = end_index - start_index
	return text.substr(start_index, substr_length)

func _play_node():
	var text = _Story_Reader.get_text(_did, _nid)
	print("TEXT IS :")
	print(text)
	var speaker = _get_tagged_text("speaker", text)
	var dialog = _get_tagged_text("dialog", text)


	_Speaker_Label.text = speaker
	_Body_Label.bbcode_text = dialog
	_Body_AnimationPlayer.play("TextDisplay")
	#_Body_Label.Dialog_start()
	


