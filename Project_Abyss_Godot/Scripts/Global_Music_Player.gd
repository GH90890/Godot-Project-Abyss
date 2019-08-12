extends Node

#I would need a max sound for music, that is configurable in the menus. and keep that in mind
var configMaxSound
#I need to see what the name is of the music, for GUI memes.
var musicName
#Audio stream node???
var audioStream : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


# A FUNMCTION THAT CAN SMOOTH TRANSITION FROM ONE TRACK TO ANOTHER WITH A TIME FRAME.
#needs to see which one of the two audio streams is currently playing, and slowly put that sound to 0.
# while the other one that isn't playing is set its sound to 0 and is slowly climbing up to configMaxSound