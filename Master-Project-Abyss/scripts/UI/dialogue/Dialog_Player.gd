extends Node

onready var _Body_Label = find_node("Body_Label")
onready var _Dialog_Box = find_node("Dialog_Box")
onready var _Option_List = find_node("Option_list")
onready var _Speaker_Label = find_node("Speaker_Label")
onready var _Continue_Icon = find_node("Continue_Icon")
onready var _Registry = Global_Registry
onready var _SelectChoice_icon = find_node("SelectChoice")
#onready var _Timer = find_node("Scroll_Timer")
onready var _Body_AnimationPlayer = find_node("Body_player")
onready var _Character_Texture = find_node("Character_Texture")

onready var _Option_Button_Scene = load("res://scenes/UI/Dialog/Dialog_Option.tscn")

var _did = 0 # Current ID
var _nid = 0 # Current node ID
var _final_nid = 0 # The final node.
var _Story_Reader #reference to the story file.
var _texture_library : Dictionary = {}

#virtual methods

func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	_Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://dialog/demo/baked/test_story.tres")
	_Story_Reader.read(story)

	_load_texture()
	
	_Dialog_Box.visible = false
	_Continue_Icon.visible = false
	_SelectChoice_icon.visible = false
	_Option_List.visible = false
	
	_clear_options()

	play_dialog("texture/test")


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
		_Character_Texture.visible = false
		_get_next_node()
		if _is_playing():
			_play_node()

func _on_Option_clicked(slot):
	_SelectChoice_icon.visible = false
	_Option_List.visible = false
	_Character_Texture.visible = false
	_get_next_node(slot)
	_clear_options()
	if _is_playing():
		_play_node()
	

func _on_Body_player_animation_finished(anim_name: String) -> void:
	if _Option_List.get_child_count() == 0:
		_Continue_Icon.visible = true
	else:
		_SelectChoice_icon.visible = true
		_Option_List.visible = true
	


#public methods

func play_dialog(record_name : String):
	_did = _Story_Reader.get_did_via_record_name(record_name)
	_nid = _Story_Reader.get_nid_via_exact_text(_did, "<start>")
	_final_nid = _Story_Reader.get_nid_via_exact_text(_did, "<end>")
	_get_next_node()
	_play_node()
	_Dialog_Box.visible = true
#private methods

func _clear_options():
	var children = _Option_List.get_children()
	for child in children:
		_Option_List.remove_child(child)
		child.queue_free()
		
func _display_image(key : String):
	_Character_Texture.texture = _texture_library[key]
	_Character_Texture.visible = true

func _inject_variables(text: String) -> String:
	var variable_count = text.count("<variable>")
	
	for i in range(variable_count):
		var variable_name = _get_tagged_text("variable", text)
		var variable_value = _Registry.lookup(variable_name)
		var start_index = text.find("<variable>")
		var end_index = text.find("</variable>") + "</variable>".length()
		var substr_lenght = end_index - start_index
		text.erase(start_index, substr_lenght)
		text = text.insert(start_index, str(variable_value))
	return text

func _is_playing() -> bool:
	return _Dialog_Box.visible

func _is_waiting() -> bool:
	return _Continue_Icon.visible

func _get_next_node(slot : int = 0):
	_nid = _Story_Reader.get_nid_from_slot(_did, _nid, slot)
	
	if _nid == _final_nid: # Am I at the end? finish the dialog_box.
		_Dialog_Box.visible = false

func _get_tagged_text(tag : String, text : String):
	var start_tag = "<" + tag + ">"
	var end_tag = "</" + tag + ">"
	var start_index = text.find(start_tag) + start_tag.length()
	var end_index = text.find(end_tag)
	var substr_length = end_index - start_index
	return text.substr(start_index, substr_length)

func _load_texture():
	var did = _Story_Reader.get_did_via_record_name("Test/TextureLibrary")
	var json_text = _Story_Reader.get_text(did, 1)
	var raw_texture_library : Dictionary = parse_json(json_text)
	
	for key in raw_texture_library:
		var texture_path = raw_texture_library[key]
		var loaded_texture = load(texture_path)
		_texture_library[key] = loaded_texture


func _play_node():
	var text = _Story_Reader.get_text(_did, _nid)
	text = _inject_variables(text)
	var speaker = _get_tagged_text("speaker", text)
	var dialog = _get_tagged_text("dialog", text)
	if "<choiceJSON>" in text:
		var options = _get_tagged_text("choiceJSON", text)
		_populate_choices(options)
	if "<image>" in text:
		var library_key = _get_tagged_text("image", text)
		_display_image(library_key)
	
	_Speaker_Label.text = speaker
	_Body_Label.bbcode_text = dialog
	_Body_AnimationPlayer.play("TextDisplay")
	#_Body_Label.Dialog_start()
	
func _populate_choices(JSONtext : String):
	var choices : Dictionary = parse_json(JSONtext)
	
	for text in choices:
		var slot = choices[text]
		var new_option_button = _Option_Button_Scene.instance()
		_Option_List.add_child(new_option_button)
		new_option_button.slot = slot
		new_option_button.set_text(text)
		if new_option_button.slot == 0: # if I am the first one, I am clearly the focus!
			new_option_button.is_focus = true
		new_option_button.connect("clicked", self, "_on_Option_clicked")
