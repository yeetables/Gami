extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_backbtn_pressed():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")


func _on_backbtn_mouse_entered():
	$AnimationPlayer.play("fadein")


func _on_backbtn_mouse_exited():
	$AnimationPlayer.play("fadeout")
