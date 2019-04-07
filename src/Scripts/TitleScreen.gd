extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_playbutton_pressed():
	get_tree().change_scene("res://Scenes/World2.tscn")

func _on_credbutton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
