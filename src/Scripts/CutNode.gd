extends Node

var count = 0
var cutscene1 = ["My child...", "Your time of rest must end.", "Wake up.", "Our lands are wrought with sickness. The most able creates have been forced to flee."]
var times = [1, 1.5, 3, 0.75]
var end = false

func _ready():
	$Fader.play("White")
	print("Flag1")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Words":
		if count < 4:
			$AnimationPlayer.set_speed_scale(times[count])
			$Label.set_text(cutscene1[count])
			$AnimationPlayer.play("Words")
			count += 1
		else:
			if end == false:
				$AnimationPlayer.play("Player")
				end = true
	elif anim_name == "Player":
		$Fader.play("Black")
		$AudioStreamPlayer._set_playing(false) # stop the music

func _on_Fader_animation_finished(anim_name):
	if anim_name == "White":
		$Label.set_text(cutscene1[count])
		$AnimationPlayer.play("Words")
		print("Flag2")
		count += 1
	if anim_name == "Black":
		# switch to first level
		get_tree().change_scene("res://Scenes/World2.tscn")