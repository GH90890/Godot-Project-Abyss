extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(0, 0)

var definition_bars = 10
var total_w = 400
var total_h = 200
var min_freq = 20
var max_freq = 20000

var max_db = 0
var min_db = -40

var accel = 6
var histogram = [] # basical a bar ghrap that spans over a bars 

func _ready() -> void:
	max_db += get_parent().volume_db
	min_db += get_parent().volume_db
	
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
	var draw_pos = Vector2(0,0)
	var w_interval = total_w / definition_bars
	
	draw_line(Vector2(0, -total_h), Vector2(total_w, -total_h), Color.orangered, 2.0 , true)
	
	for i in range(definition_bars):
		draw_line(draw_pos, draw_pos + Vector2(0, -histogram[i] * total_h), Color.orangered, 4.0 , true)
		draw_pos.x += w_interval
