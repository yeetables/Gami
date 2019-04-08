extends Node

var count = 0
var cutscene1 = [
"My child...", 
"Your time of rest must end. Wake up.", 
"Our lands are wrought with sickness. The most abled creatures have been forced to flee.", 
"Those who cannot leave struggle greatly. Our state is dire, and I fear the worst.", 
"Yet you...you have remained untouched. Whether through resilience or pure luck, you have continued to flourish in the midst of the mountain’s decay.", 
"I can only hope that your shining spirit will be enough to free us from this darkness.", 
"Two hearts of the mountain have been lost and broken. They are stones of Vitality and Enhancement. You must retrieve them, reunite their shards, and ascend the mountain.", 
"We must restore our home and save our people."
]
var times = [1.5, 1.3, 0.75, 0.75, 0.6, 0.75, 0.55, 1]
#var italic = [false, true, true, false]
#var italicFont = load("res://Assets/merriweather.italic.ttf")
#var regularFont = load("res://Assets/merriweather.regular.ttf")

var end = false # if all words has ended
func _ready():
#	$Fader.play("White")
	$NonBackground/HUD/nextline.visible = false
	$NonBackground/icon.visible = false
	$NonBackground/burrow.visible = false
	
	$NonBackground/Label.set_text(cutscene1[count])
	$AnimationPlayer.play("Words")
	count += 1
	$NonBackground/HUD/nextline.visible = true
	
func _physics_process(delta):
	# advance to the end of this when we are playing "Words"
	# just so that they won't accidentally skip a line
	if Input.is_action_just_pressed("ui_lmb") and \
	$AnimationPlayer.get_current_animation_position() >= 0.5 and \
	$AnimationPlayer.get_current_animation() == "Words":
		
		var totalTime = $AnimationPlayer.get_current_animation_length()
		var speed = $AnimationPlayer.get_speed_scale()
		$AnimationPlayer.advance(totalTime/speed)
		
	if Input.is_action_just_pressed("ui_skip"):
		get_tree().change_scene("res://Scenes/World2.tscn")
		
	if Input.is_action_just_pressed("ui_lmb") and $BackgroundAnim.is_playing() and not $AnimationPlayer.is_playing():
		if count !=3:
			$BackgroundAnim.advance($BackgroundAnim.get_current_animation_length()-$BackgroundAnim.get_current_animation_position())

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Words":
		if count < 8:
			$AnimationPlayer.set_speed_scale(times[count])
			$NonBackground/Label.set_text(cutscene1[count])
			count += 1
			if count == 3:
				$Fader.play("bgWhite")
				$BackgroundAnim.play("backgroundScroll")
			elif count !=8:
				$AnimationPlayer.play("Words")
#		if count == 8:
#			$NonBackground/icon.visible = true
#			$NonBackground/burrow.visible = true
		else:
			print("not here", count)
			if end == false:
				$AnimationPlayer.play("Player")
				end = true
				
	elif anim_name == "Player":
		$Fader.play("PlayerHide")
		$NonBackground/AudioStreamPlayer._set_playing(false) # stop the music
		
		
func _on_Fader_animation_finished(anim_name):
	if anim_name == "bgWhite":
		$AnimationPlayer.play("Words")
		
	if anim_name == "Black":
		# switch to first level
		if not end:
			$ParallaxBackground.queue_free()
			$NonBackground/icon.visible = true
			$NonBackground/burrow.visible = true
			$Fader.play("PlayerShow")
			
	elif anim_name == "PlayerHide":
		get_tree().change_scene("res://Scenes/World2.tscn")
	
	elif anim_name == "PlayerShow":
		$AnimationPlayer.play("Words")

func _on_BackgroundAnim_animation_finished(anim_name):
	if anim_name == "backgroundScroll":
		$Fader.play("Black")
		$NonBackground/HUD/nextline.visible = false
		
