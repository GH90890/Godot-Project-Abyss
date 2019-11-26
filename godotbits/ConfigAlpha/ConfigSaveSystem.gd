extends Node

const SAVE_PATH = "res://config.cfg"
var _config_file = ConfigFile.new()

#=== TODO FIND A BETTER WAY TO DO THIS

var _settings = {
	"audio": {
		"sfx_value":get_node("res://ConfigSaveSystem.gd")
		},
}

func _ready() -> void:
#	save_settings()
	load_settings()
	print(_settings)

func save_settings():
	print("I am saving..")
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if (error != OK):
		print("An error was found with the save file : %s" %error)
		return null
		
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.get_value(section, key, null)