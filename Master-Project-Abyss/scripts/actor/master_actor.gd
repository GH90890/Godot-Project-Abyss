extends Spatial


# this handles most character effects, like swapping sprites, and other goodness.

onready var front = get_node("front_image")
onready var shadows = get_node("shadow_image")
onready var shadows_mirror = get_node("shadow_image_mirror")


var character_image_location = "res://images/character/bobbington/"


func _ready() -> void:
	_change_sprite(3) # change this to any string id for a sprite ID.

func _change_sprite(sprite_id) -> void:
	
	var load_path = (character_image_location + str(sprite_id) + ".png")
	if (ResourceLoader.exists(load_path)):
		pass #true , keep path
	else:
		load_path = "res://images/character/NULL/errored.png"
		print("HEY DUMMY, THAT SPRITE DOES NOT EXIST.")
	
	var frontmesh = front.get_surface_material(0)
	var new_texture = ImageTexture.new();
	
	new_texture.load(load_path); # get image from folder
	frontmesh.albedo_texture = new_texture;
