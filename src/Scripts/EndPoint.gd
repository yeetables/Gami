extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): # Replace with function body.
		Global.PLAYER_INSTANCE = null
		loadNextLevel()

func loadNextLevel():
	print("finished")
	get_tree().change_scene("res://Scenes/CutScenes/Dragon.tscn")
	