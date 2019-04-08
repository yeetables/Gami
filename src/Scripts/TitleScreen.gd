extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var pressed = ""

func _on_playbutton_pressed():
	pressed = "play"
	$AnimationPlayer.play("FadeOut")
	

func _on_credbutton_pressed():
	pressed = "credit"
	$AnimationPlayer.play("FadeOut")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		if pressed == "play":
			get_tree().change_scene("res://Scenes/Cutscenes/Intro.tscn")
		elif pressed == "credit":
			get_tree().change_scene("res://Scenes/Credits.tscn")
