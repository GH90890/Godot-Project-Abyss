extends Node

var path = "user://data.json"

#default data
var default_data = {
	"player" : {
		"name" : "Jamie",
		"level" : 3,
		"health" : 10
	},
	"options" : {
		"music_volume" : 0.5,
		"cheat_mode" : false
	},
	"levels_complete" : [1, 2, 3]
}

var data = { } # empty data Will ve loaded lated!


func _ready():
	load_game()
	#update_text()


func load_game():
	var file = File.new()
	
	if not file.file_exist(path):
		#reset_data()
		return
	
	file.open(path, file.READ) #opens the file
	
	var text = file.get_as_text() #turns it onto a flat string
	
	data = parse_json(text) #parses it into a json.
	
	
	file.close()
	

func save_game():
	var file
	
	file = File.new()
	
	file.open(path, file.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
	
func reset_data():
	#resets to defaults
	data = default_data.duplicate(true)





