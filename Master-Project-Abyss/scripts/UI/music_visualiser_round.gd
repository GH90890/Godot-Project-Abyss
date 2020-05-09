extends Control

onready var spectrum = AudioServer.get_bus_effect_instance(0, 0)

export var definition_bars = 14
export var colorBar = Color(255,255,255)
var lineThickness = 8.0

var total_w = 400
var total_h = 200
var min_freq = 20
var max_freq = 20000

var max_db = 0
var min_db = -40

var accel = 18
var histogram = [] # basical a bar ghrap that spans over a bars 

func _ready() -> void:
	max_db += $"../AudioStreamPlayer".volume_db
	min_db += $"../AudioStreamPlayer".volume_db
	
	for i in range(definition_bars): # how many bars you got?
		histogram.append(0)          # now we got all these values to 0! meaning i got a an array of 0's

func _process(delta):
	var freq = min_freq
	var interval =  (max_freq - min_freq) / definition_bars
	
	for i in range(definition_bars):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq , freqrange_low) 
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq , freqrange_high) 
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.6 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.05 , 1)
		
		histogram[i] = lerp(histogram[i], mag , accel * delta)
		
	update()

func _draw():
	var angle = PI
	var angle_interval = 0.8 * PI / definition_bars
	var radius = 60 # increases circle size
	var length = 80 
	
	for i in range(definition_bars):
		var normal = Vector2(0, -1).rotated(angle)
		var start_pos = normal * radius
		var end_pos = normal * (radius + histogram[i] * length)
		draw_line(start_pos, end_pos, colorBar, lineThickness , true)
		angle += angle_interval
		
func changeColor(red,green,blue,delta):
	#and lerp them to 255 255 255. 
	
	var c1 = colorBar
	var c2 = Color(255,255,255)
	var li_c = c1.linear_interpolate(c2, 0.5)
	
	#then get the colors from the change input itself
	
	
	# lerp to that color.
	pass


func _on_Button_pressed() -> void:
	changeColor(255,0,0, 1)
