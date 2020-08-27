extends Spatial


# this handles most character effects, like swapping sprites, and other goodness.

onready var front = get_node("front_image")
onready var shadows = get_node("shadow_image")
onready var shadows_mirror = get_node("shadow_image_mirror")

var flash_active = false # checked then the character will flash once.
var flashing = true #allows for the begining values to be set first.
var currentvalue : float =  0.0

var character_image_location = "res://images/character/bobbington/"
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_page_up"):
		_begin_flash()
	
	if (flash_active):
		_light_flash(delta)

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
	var shadowmesh = shadows.get_surface_material(0)
	var shadowMmesh = shadows_mirror.get_surface_material(0)
	var new_texture = ImageTexture.new();
	
	new_texture.load(load_path); # get image from folder
	frontmesh.albedo_texture = new_texture;
	shadowmesh.albedo_texture = new_texture;
	shadowMmesh.albedo_texture = new_texture;
	
func _begin_flash():
	flashing = true
	flash_active = true

func _light_flash(delta):
	# this makes the character flash into a white color, maybe can be changed to flash into another color except black.
	#might mess if any GI Probes are used. but might look good and we cannot call what looks good a bug :sunglasses:
	if (flashing):
		# I set all the values to its beginings.
		currentvalue = 1.0
		# PLAY PLING.WAV MAYBE?
		flashing = false
		print ("I've set the starting things!")
		
	currentvalue = lerp(currentvalue, 0.0 , 3.0 * delta )
	
	var flashtarget = front.get_surface_material(0)
	flashtarget.emission_energy = currentvalue
	
	if (currentvalue == 0.0):
		#I've reached the goal of 0. i no longer need to flash.
		flash_active = false
		print ("I've reached the very end!")
