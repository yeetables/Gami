extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE, "*.tscn") var scene_file

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): # Replace with function body.
		Global.PLAYER_INSTANCE = null
		call_deferred("loadNextLevel", scene_file)
#		Global.switch_scene()

func loadNextLevel(scene_file):
	print("transport")
	get_tree().change_scene(scene_file)
	