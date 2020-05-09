extends Polygon2D

export var rand_color = false
var shard_count = 45

var shard_velocity_map = {}


func _ready() -> void:
	randomize()

func explode():
	#this adds more point to our polgyon later on
	var points = polygon
	for _i in range(shard_count):
		points.append(Vector2(randi()%1000, randi()% 1000))
	
	var delaunay_points = Geometry.triangulate_delaunay_2d(points)
	
	print(delaunay_points)
	
	if not delaunay_points:
		print ("it errored. no delaunay points found!")
	
	# make list of triangle shard pool
	
	
	
		
	for index in len(delaunay_points) / 3:
		var shard_pool = PoolVector2Array()
		#find the center
		var center = Vector2.ZERO
		
		for n in range(3):
			shard_pool.append(points[delaunay_points[(index * 3) + n]])
			center += points[delaunay_points[(index * 3) + n]]
			
		#adding all the poiunts devided by 3
		center /= 3
		
		var shard = Polygon2D.new()
		shard.polygon = shard_pool
		
		if rand_color:
			shard.color = Color(randf(),randf(),randf(), 1)
		else:
			shard.texture = texture
			
		#shard_velocity_map[shard] = Vector2(500, 500) - center
		shard_velocity_map[shard] = (Vector2(500, 500) - center).normalized() * 111
		add_child(shard)
		
	color.a = 0
	
func reset():
	color.a = 1
	for child in get_children():
		if child.name != "Camera2D":
			child.queue_free()
		
	shard_velocity_map = {}
	
	
func _process(delta):
	for child in shard_velocity_map.keys():
		child.position -= shard_velocity_map[child] * delta * 2
		child.rotation -= shard_velocity_map[child].x * delta * -0.0002
		# apply gravity to velocity map so the triang falls
		shard_velocity_map[child].x -= delta * 1

func _input(event):
	if Input.get_action_strength("ui_accept"):
		explode()
	elif Input.get_action_strength("ui_cancel"):
		reset()
	if Input.get_action_strength("ui_left"):
		rand_color = true
	if Input.get_action_strength("ui_right"):
		rand_color = false
	
