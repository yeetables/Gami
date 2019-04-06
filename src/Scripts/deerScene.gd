extends Node

var count = 0
var line = 0
var deer1 = ["Nnngh...", "Footsteps..? Please. Help..."]
var deer2 = ["I...eughh...My Leg.", "Please... A falling branch broke my leg. I'm starving, but I can't move.", "I need your help... badly."]
var drag1 = "You have the power of the Stone of Vitality. Do you feel it within?"
var deer3 = ["Oh...", "My leg! I can move!"]
var deer4 = ["I... *sob*... I thought I would die here. Thank you so much. Words can't express...", "I won't forget you, my friend"]
var drag2 = ["My child... I am proud. You have given our friend a second chance at life.", "Stay strong. You have only just begun."]
var t_count = 0
var times = []

var part = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$bgAnim.play("fadeIn")


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
			$dragonVoice.set_text(drag2)
			$PlyAnim.set_speed_scale(times[t_count])
			t_count += 1
			$PlyAnim.play("dragCycle")
	elif anim_name == "filterOut":
		$PlyAnim.set_speed_scale(1)
		#$PlyAnim.play("kiss")
	elif anim_name == "fadeOut":
		#get_tree().change_scene("res://Scenes/World2.tscn")
		pass


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
				#$PlyAnim.play("heart")
			else:
				$deerVoice.set_text(deer3[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 4:
			if line == count:
				$bgAnim.set_speed_scale(1)
				part += 1
				$bgAnim.play("fadeIn")
			else:
				$deerVoice.set_text(deer4[line])
				$PlyAnim.set_speed_scale(times[t_count])
				t_count += 1
				$PlyAnim.play("deerCycle")
		elif part == 5:
			if line == count:
				$bgAnim.set_speed_scale(1)
				$bgAnim.play("fadeOut")
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