extends Control

var BGfinished = preload("res://Assets/Sprites/Objects/Background/title-screen-end.png")

func _ready():
	Global.FRAGMENTS_G = 0
	Global.FRAGMENTS_R = 0
	if Global.GAME_FINISHED == true:
		$BG.set_texture(BGfinished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var pressed = ""

func _on_playbutton_pressed():
	pressed = "play"
	$AnimationPlayer.play("FadeOut")
	print("pressed")
	

func _on_controlbutton_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")


func _on_playbutton_mouse_entered():
	$Play/AnimPlay.play("fadein")


func _on_playbutton_mouse_exited():
	$Play/AnimPlay.play("fadeout")


func _on_controlbutton_mouse_entered():
	$Controls/AnimCtrl.play("fadein")


func _on_controlbutton_mouse_exited():
	$Controls/AnimCtrl.play("fadeout")

func _on_credbutton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")	

func _on_credbutton_mouse_entered():
	$Credits/AnimCred.play("fadein")

func _on_credbutton_mouse_exited():
	$Credits/AnimCred.play("fadeout")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		if pressed == "play":
			get_tree().change_scene("res://Scenes/Cutscenes/Intro.tscn")
