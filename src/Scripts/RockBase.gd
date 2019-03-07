extends StaticBody2D

const ROCK_SCENE = "res://Scenes/fallRocks/Rock.tscn"
var start = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var frame_count = 0
func _physics_process(delta):
	if start:
		if frame_count == 0:
			create_rock()
			$CollisionShape2D.disabled = true
		if frame_count == 70:
			$CollisionShape2D.disabled = false
		
		frame_count = (frame_count+1) % 100
	
func create_rock():
	var scene = ResourceLoader.load(ROCK_SCENE)
	var instance = scene.instance()
	
	add_child(instance)
	
#	instance.set_global_position(get_global_position())

func start():
	start = true
	
func stop():
	start = false