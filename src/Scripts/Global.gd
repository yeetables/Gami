extends Node2D

const FOX_SCENE_PATH = "res://Scenes/Player.tscn"
const SQUIRREL_SCENE_PATH = "res://Scenes/PlayerSquirrel.tscn"

const FOX_INSTANCE_PATH = "/root/World/Player"
const SQUIRREL_INSTANCE_PATH = "/root/World/PlayerSquirrel"

var PLAYER_POS = Vector2()
#var CAMERA_POS = Vector2()
var PLAYER_INSTANCE = null
var Level1Finished = false
var DASH_ENABLED = false
var FRAGMENTS_R = 0
var FRAGMENTS_G = 0
var CAN_MOVE = true
var GAME_FINISHED = false

func _ready():
	var root = get_tree().get_root()
	PLAYER_INSTANCE = root.get_node(FOX_INSTANCE_PATH)
	
func _physics_process(delta):
	if PLAYER_INSTANCE:
		PLAYER_POS = PLAYER_INSTANCE.get_node("Body").get_global_position()
		#CAMERA_POS = PLAYER_INSTANCE.get_node("Body/Camera2D").get_global_position()
	
func add_new_player(scene_path):
	var scene = ResourceLoader.load(scene_path)
	var instance = scene.instance()
	
	get_tree().get_root().get_node("/root/World").add_child(instance)
#    get_tree().set_current_scene(instance)
#    set_child_pos(instance, PLAYER_POS)
	instance.get_node("Body").set_global_position(PLAYER_POS)
	#instance.get_node("Body/Camera2D").set_global_position(CAMERA_POS)
#	print(PLAYER_POS) #CAMERA_POS)
#	print(instance.get_global_position())
#	print(instance.get_node("Body").get_global_position())
	
	return instance
	
var respawn_node = "/root/World/CheckPoints/SpawnPoint"

func add_player(pos):
	var scene = ResourceLoader.load(FOX_SCENE_PATH)
	var instance = scene.instance()
	get_tree().get_root().get_node("/root/World").add_child(instance)
	instance.get_node("Body").set_global_position(pos)
	PLAYER_INSTANCE = instance
	move_camera(pos)
	
func move_camera(pos):
	var camera_instance = get_tree().get_root().get_node("/root/World/Camera")
	if (pos.y > 300): # if the player is at the bottom, don't the camera go down there
			pos.y = 300 # if change this value, need to change CameraMan script as well
	camera_instance.set_global_position(pos)
	
func respawn_player():
	var spawn_pos = get_tree().get_root().get_node(respawn_node).get_global_position()
#	PLAYER_INSTANCE.get_node("Body").set_global_position(spawn_pos)
	PLAYER_INSTANCE.queue_free()
	add_player(spawn_pos)
	CAN_MOVE = false
	#var timer = get_tree().get_root().get_node("/root/World/Player/Body/DeathTimer")
	#timer.start()
	#print(timer)
#
func change_checkPoint(n):
#	if n == 2:
#		respawn_node = "/root/World/CheckPoints/SpawnPoint2"
#	if n == 3:
#		respawn_node = "/root/World/CheckPoints/SpawnPoint3"
	if respawn_node != n:
		# remove the old checkpoint
		get_tree().get_root().get_node(respawn_node).queue_free()
		respawn_node = n
		
#func set_child_pos(instance, pos):
#    for child in instance.get_children():
#        if child.get_child_count() > 0:
#            set_child_pos(child, pos)
#        child.set_global_position(pos)