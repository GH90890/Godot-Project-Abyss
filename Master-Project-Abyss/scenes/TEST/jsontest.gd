extends Node

var _Story_Reader #reference to the story file.
var _character_position : Dictionary = {}
var _location_storyfile = "docks/start"

# Called when the node enters the scene tree for the first time.
func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	_Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://Storyscripts/character locations/DEMO/docks_baked.tres")
	_Story_Reader.read(story)
	
	_load_character_positions()

func _load_character_positions():
	var did = _Story_Reader.get_did_via_record_name(_location_storyfile)
	var json_text = _Story_Reader.get_text(did, 1)
	var raw_characters : Dictionary = parse_json(json_text)
	
	for key in raw_characters.characters: #> goes into the character array.
		#var character_path = raw_characters[key]
		#var loaded_texture = load(character_path)
		#_character_position[key] = loaded_texture
		var _characterPOS = find_node("SPWN-Actor" + str(key.id))
		
		print(key.name)
