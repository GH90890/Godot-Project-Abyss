extends Node

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"mute": Globals.get("Settings/mute"),
		"sfx_value":Globals.get("Settings/mute")
		}
}

func _ready() -> void:
	load_settings()
	save_settings()

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if (error != OK):
		print("An error was found with the save file : %s" %error)
		return[]