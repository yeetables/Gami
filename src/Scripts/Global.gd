extends Node2D

enum {
	FOX, # 0
	SQUIRREL # 1
}
	
const FOX_SCENE_PATH = "res://Scenes/Player.tscn"
const SQUIRREL_SCENE_PATH = "res://Scenes/PlayerSquirrel.tscn"

const FOX_INSTANCE_PATH = "/root/World/Player"
const SQUIRREL_INSTANCE_PATH = "/root/World/PlayerSquirrel"

var CURRENT_FORM = FOX
var PLAYER_POS = Vector2()
#var CAMERA_POS = Vector2()
var PLAYER_INSTANCE = null

var PLAYER_IN_CLIMING_AREA = false

const TREE_LOCATION = Vector2(415.55,-798.63)
var WATERAREA_ENTERED = false
var WATERAREA_DIGGED = false

func _ready():
	var root = get_tree().get_root()
	PLAYER_INSTANCE = root.get_node(FOX_INSTANCE_PATH)
	
func _physics_process(delta):
	if PLAYER_INSTANCE:
		PLAYER_POS = PLAYER_INSTANCE.get_node("Body").get_global_position()
		#CAMERA_POS = PLAYER_INSTANCE.get_node("Body/Camera2D").get_global_position()
	
func switch_form():
	PLAYER_INSTANCE.queue_free()
	PLAYER_INSTANCE = null
	var new_form = (CURRENT_FORM + 1) % 2
	
	if new_form == FOX:
	   PLAYER_INSTANCE =  add_new_player(FOX_SCENE_PATH)
	elif new_form == SQUIRREL:
	   PLAYER_INSTANCE =  add_new_player( SQUIRREL_SCENE_PATH)

	CURRENT_FORM = new_form
	
	
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
func spawn_holy_tree():
	var scene = ResourceLoader.load("res://Scenes/tree.tscn")
	var instance = scene.instance()
	var world_node = get_tree().get_root().get_node("/root/World")
	var second_last_node = world_node.get_child(world_node.get_child_count()-2)
	world_node.add_child_below_node(second_last_node, instance)
	instance.set_global_position(TREE_LOCATION)
	
func add_player(pos):
	var scene = ResourceLoader.load(FOX_SCENE_PATH)
	var instance = scene.instance()
	get_tree().get_root().get_node("/root/World").add_child(instance)
	instance.get_node("Body").set_global_position(pos)
	PLAYER_INSTANCE = instance
	move_camera(pos)
	
func move_camera(pos):
	var camera_instance = get_tree().get_root().get_node("/root/World/Camera")
	camera_instance.set_global_position(pos)
	
func respawn_player():
	var spawn_pos = get_tree().get_root().get_node(respawn_node).get_global_position()
#	PLAYER_INSTANCE.get_node("Body").set_global_position(spawn_pos)
	PLAYER_INSTANCE.queue_free()
	add_player(spawn_pos)
#
func change_checkPoint(n):
#	if n == 2:
#		respawn_node = "/root/World/CheckPoints/SpawnPoint2"
#	if n == 3:
#		respawn_node = "/root/World/CheckPoints/SpawnPoint3"
	respawn_node = n
#func set_child_pos(instance, pos):
#    for child in instance.get_children():
#        if child.get_child_count() > 0:
#            set_child_pos(child, pos)
#        child.set_global_position(pos)