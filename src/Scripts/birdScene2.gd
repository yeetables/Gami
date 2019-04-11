extends Node

var birdWords = ["I heard something and followed the sound here. Are you all right?", "Again? But this time... my goodness.", "I can hear... everything. The soft breeze as it passes through your fur. The water in the valley's stream.", "If I focus, I can hear your heartbeat.", "My flock..! I can hear them now. A rather noisy bunch after all, aren't they? I suppose I had better catch up to them.", "You have made my world much bigger than I could have imagined. There are great things in store for you, friend."]
var dragWords = ["The Stone of Enhancement reinforces a given skill or strength.", "Just as the creatures benefit from your help, in doing so, your spirit strengthens.", "I believe the bird is correct in saying your future is bright.", "Yet celebrate not! The most treacherous part of your journey is yet to come.", "Perhaps we will succeed in our quest after all."]
var times = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$bgAnim.play("fadeIn")

func changeScene():
	get_tree().change_scene("res://Scenes/moutain.tscn")
	
#warning-ignore:unused_argument
func _physics_process(delta):
	# advance to the end of this when we are playing "Words"
	# just so that they won't accidentally skip a line
	if ($PlyAnim.get_current_animation() == "birdCycle" or $PlyAnim.get_current_animation() == "dragCycle")and $PlyAnim.is_playing():
		$HUD/nextline.visible = true
	else:
		$HUD/nextline.visible = false
		
	if Input.is_action_just_pressed("ui_lmb") and \
	$PlyAnim.get_current_animation_position() >= 0.5 and \
	($PlyAnim.get_current_animation() == "birdCycle" or $PlyAnim.get_current_animation() == "dragCycle"):
		
		var totalTime = $PlyAnim.get_current_animation_length()
		var speed = $PlyAnim.get_speed_scale()
		$PlyAnim.advance(totalTime/speed)
		
	if Input.is_action_just_pressed("ui_skip"):
		changeScene()
		
	if not $Player/playerAni.is_playing():
		$Player/playerAni.play("FoxIdle")

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
		#Change scene here. 
		changeScene()

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
			$heartSFX.play()
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
