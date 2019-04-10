extends Node

var count = 0
var line = 0
var deer1 = ["Nnngh...", "Footsteps..? Please. Help..."]
var deer2 = ["I...eughh...My Leg.", "Please... A falling branch broke my leg. I'm starving, but I can't move.", "I need your help... badly."]
var drag1 = "You have the power of the Stone of Vitality. Do you feel it within?"
var deer3 = ["Oh...", "My leg! I can move!"]
var deer4 = ["I... I thought I would die here. Thank you so much. Words can't express...", "I won't forget you, my friend."]
var drag2 = ["My child... I am proud. You have given our friend a second chance at life.", "Stay strong and go forth."]
var t_count = 0
var times = [1,1,1,1,1,1,1,1,1,1,1,1]

var part = 0
var shouldLeave = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$bgAnim.play("fadeIn")
	$DeerAnim.play("deerHurt")
	
func changeScene():
	get_tree().change_scene("res://Scenes/Cutscenes/Bird1.tscn")
	
func _physics_process(delta):
	# advance to the end of this when we are playing "Words"
	# just so that they won't accidentally skip a line
	if ($PlyAnim.get_current_animation() == "deerCycle" or $PlyAnim.get_current_animation() == "dragCycle") and $PlyAnim.is_playing():
		$HUD/nextline.visible = true
	else:
		$HUD/nextline.visible = false
		
	if Input.is_action_just_pressed("ui_lmb") and \
	$PlyAnim.get_current_animation_position() >= 0.5 and \
	($PlyAnim.get_current_animation() == "deerCycle" or $PlyAnim.get_current_animation() == "dragCycle"):
		
		var totalTime = $PlyAnim.get_current_animation_length()
		var speed = $PlyAnim.get_speed_scale()
		$PlyAnim.advance(totalTime/speed)
		
	if Input.is_action_just_pressed("ui_skip"):
		changeScene()
		
	if not $Player/playerAni.is_playing():
		$Player/playerAni.play("FoxIdle")

func _on_bgAnim_animation_finished(anim_name):
	if anim_name == "fadeIn":
		count = len(deer1)
		$deerVoice.set_text(deer1[0])
		$PlyAnim.set_speed_scale(times[t_count])
		t_count += 1
		$PlyAnim.play("deerCycle")
	elif anim_name == "filterIn":
		if part == 2:
			$dragonVoice.set_text(drag1)
			$PlyAnim.set_speed_scale(times[t_count])
			t_count += 1
			$PlyAnim.play("dragCycle")
		elif part == 5:
			line = 0
			count = len(drag2)
			$dragonVoice.set_text(drag2[line])
			$PlyAnim.set_speed_scale(times[t_count])
			t_count += 1
			$PlyAnim.play("dragCycle")
	elif anim_name == "filterOut":
		if shouldLeave:
			$PlyAnim.play("leave")
		else:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("kiss")
#			$Player/playerAni.play("FoxKiss")
	elif anim_name == "fadeOut":
		print("done")
		changeScene()

func _on_PlyAnim_animation_finished(anim_name):
	if anim_name == "deerCycle" or anim_name == "dragCycle":
		line += 1
		if part == 0:
			if line == count:
				$PlyAnim.set_speed_scale(1)
				part += 1
				$PlyAnim.play("enter")
			else:
				$deerVoice.set_text(deer1[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 1:
			if line == count:
				$bgAnim.set_speed_scale(1)
				part += 1
				$bgAnim.play("filterIn")
			else:
				$deerVoice.set_text(deer2[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 2:
			$bgAnim.set_speed_scale(1)
			part += 1
			$bgAnim.play("filterOut")
		elif part == 3:
			if line == count:
				$PlyAnim.set_speed_scale(1)
				part += 1
				$PlyAnim.play("heart")
			else:
				$deerVoice.set_text(deer3[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 4:
			if line == count:
				$bgAnim.set_speed_scale(1)
				part += 1
				$bgAnim.play("filterIn")
			else:
				$deerVoice.set_text(deer4[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 5:
			if line == count:
				$bgAnim.set_speed_scale(1)
				shouldLeave = true
				$bgAnim.play("filterOut")
			else:
				$dragonVoice.set_text(drag2[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("dragCycle")
	elif anim_name == "enter":
		line = 0
		count = len(deer2)
		$deerVoice.set_text(deer2[0])
		$PlyAnim.set_speed_scale(times[t_count])
		t_count += 1
		$PlyAnim.play("deerCycle")
	elif anim_name == "kiss":
		line = 0
		count = len(deer3)
		$deerVoice.set_text(deer3[0])
		$PlyAnim.set_speed_scale(times[t_count])
		t_count += 1
		$PlyAnim.play("deerCycle")
	elif anim_name == "heart":
		line = 0
		count = len(deer4)
		$deerVoice.set_text(deer4[0])
		$PlyAnim.set_speed_scale(times[t_count])
		t_count += 1
		$PlyAnim.play("deerCycle")
	elif anim_name == "leave":
		$bgAnim.play("fadeOut")