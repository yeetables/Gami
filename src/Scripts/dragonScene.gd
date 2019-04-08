extends Node

var words = [
"My child, you have made it.", 
"As you may have expected, it was I who was guiding you to this point.", 
"I am the guardian of the mountain and all its inhabitants. I am overjoyed to finally meet you. And yet...", 
"We do not have much time.", 
"You have collected the Stones of Vitality and Enhancement.", 
"The full power of the stones cannot be unleashed until all three are united. You still require the Stone of Wisdom to restore our home.", 
"I was once the keeper of the three stones. But my life is coming to an end, and I no longer have the strength to harness their essence.", 
"I scattered the two stones in hope that a willing creature would find them. When the animals all fled, I feared nobody would dare carry this burden.", 
"Yet not only have you endured, but prospered. You have far exceeded my expectations.", 
"Thank you for making my final moments ones of hope, joy, and...",
 "...relief.", 
"When I pass, the Stone of Wisdom will be released to you. It will not be long now. So I must ask, will you accept my gift?", 
"I am...pleased. I may now rest easy.", 
"It is time.", 
"The future of the mountain rests upon you now. Goodbye, my child."
]
var times = [1, 1, 0.75, 1, 1, 0.6, 0.6, 0.5, 0.75, 1, 1, 0.6, 1, 1, 1]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("start")
	$bgAnim.play("fadeIn")
	$Dragon/breath.play("sleep")
	$HUD/nextline.visible = false
	
func nextScene():
	get_tree().change_scene("res://Scenes/Credits.tscn")
	
func _physics_process(delta):
	# advance to the end of this when we are playing "Words"
	# just so that they won't accidentally skip a line
	if $PlyAnim.get_current_animation() == "textCycle" and $PlyAnim.is_playing():
		$HUD/nextline.visible = true
	else:
		$HUD/nextline.visible = false
		
	if Input.is_action_just_pressed("ui_lmb") and \
	$PlyAnim.get_current_animation_position() >= 0.5 and \
	$PlyAnim.get_current_animation() == "textCycle":
		
		var totalTime = $PlyAnim.get_current_animation_length()
		var speed = $PlyAnim.get_speed_scale()
		$PlyAnim.advance(totalTime/speed)

	if Input.is_action_just_pressed("ui_skip"):
		nextScene()
		
func _on_PlyAnim_animation_finished(anim_name):
	if anim_name == "walkUp":
		#Do like, 2 sleep cycles or something here. 
		#They do the eye opening. 
		#Then this cutscene should basically be the same. 
		print("done")
		$Dragon/Node2D/eye.play("eye-open")
#		$Label.set_text(words[line])
#		$PlyAnim.set_speed_scale(times[line])
#		line += 1
#		$PlyAnim.play("textCycle")
	elif anim_name == "textCycle":
		print("flag 2")
		if line == 6:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("bright")
		elif line == 12:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("heart")
		elif line == 15:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("explode")
		else:
			$Label.set_text(words[line])
			$PlyAnim.set_speed_scale(times[line])
			line += 1
			$PlyAnim.play("textCycle")
	elif anim_name == "bright":
		print("flag 3")
		$Label.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("textCycle")
	elif anim_name == "heart":
		print("flag 4")
		$Label.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("textCycle")
	elif anim_name == "explode":
		print("flag 5")
		$PlyAnim.play("GoToTheStone")
	elif anim_name == "GoToTheStone":
		$bgAnim.play("fadeOut")

func _on_bgAnim_animation_finished(anim_name):
	if anim_name == "fadeIn":
		print("flag 1")
		$PlyAnim.play("walkUp")
	if anim_name == "fadeOut":
		nextScene()
		
func _on_eye_animation_finished(anim_name):
	if anim_name == "eye-open":
		print("?????")
		$Label.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("textCycle")
