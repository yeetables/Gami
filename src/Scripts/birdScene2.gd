extends Node

var birdWords = ["I heard something and followed the sound here. Are you all right?", "Again? But this time... my goodness", "I can hear... everything. The soft breeze as it passes through your fur. The water in the valley's stream.", "If I focus, I can hear your heartbeat.", "My flock..! I can hear them now. A rather noisy bunch after all, aren't they? I suppose I had better catch up to them.", "You have made my world much bigger than I could have imagined. There are great things in store for you, friend."]
var dragWords = ["The Stone of Enhancement reinforces a given skill or strength.", "Just as the creatures benefit from your help, in doing so, your spirit strengthens.", "I believe the bird is correct in saying your future is bright.", "Yet celebrate not! The most treacherous part of your journey is yet to come.", "Perhaps we will succeed in our quest after all."]
var times = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$bgAnim.play("fadeIn")


func _on_bgAnim_animation_finished(anim_name):
	if anim_name == "fadeIn":
		$PlyAnim.set_speed_scale(1)
		$PlyAnim.play("enter")
	elif anim_name == "filterIn":
		$dragVoice.set_text(dragWords[line-6])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("dragCycle")
	elif anim_name == "fadeOut":
		pass
		#Change scene here. 


func _on_PlyAnim_animation_finished(anim_name):
	if anim_name == "enter":
		$birdVoice.set_text(birdWords[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("birdCycle")
	elif anim_name == "birdCycle":
		if line == 1:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("kiss")
		elif line == 6:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("exit")
		else:
			$birdVoice.set_text(birdWords[line])
			$PlyAnim.set_speed_scale(times[line])
			line += 1
			$PlyAnim.play("birdCycle")
	elif anim_name == "kiss":
		$birdVoice.set_text(birdWords[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("birdCycle")
	elif anim_name == "exit":
		$bgAnim.play("filterIn")
	elif anim_name == "dragCycle":
		if line == 11:
			$bgAnim.play("fadeOut")
		else:
			$dragVoice.set_text(dragWords[line-6])
			$PlyAnim.set_speed_scale(times[line])
			line += 1
			$PlyAnim.play("dragCycle")
