extends Node

var count = 0
var cutscene1 = ["My child...", "Your time of rest must end. Wake up.", "Our lands are wrought with sickness. The most abled creatures have been forced to flee.", "Those who cannot leave struggle greatly. Our state is dire, and I fear the worst.", "Yet you...you have remained untouched. Whether through resilience or pure luck, you have continued to flourish in the midst of the mountain’s decay.", "I can only hope that your shining spirit will be enough to free us from this darkness.", "Two hearts of the mountain have been lost and broken. The stones of Vitality and Enhancement. You must retrieve them, reunite their shards, and ascend the mountain.", "We must restore our home and save our people."]
var times = [2, 1.3, 0.75, 0.75, 0.6, 0.75, 0.55, 1]
#var italic = [false, true, true, false]
#var italicFont = load("res://Assets/merriweather.italic.ttf")
#var regularFont = load("res://Assets/merriweather.regular.ttf")
var end = false

func _ready():
	$Fader.play("White")
	print("Flag1")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Words":
		if count < 8:
			$AnimationPlayer.set_speed_scale(times[count])
			$Label.set_text(cutscene1[count])
			$AnimationPlayer.play("Words")
			count += 1
			if count == 3:
				$icon.visible = true
				$TileMap.visible = true
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