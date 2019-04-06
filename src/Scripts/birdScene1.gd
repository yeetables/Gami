extends Node

var words = ["...", "Oh, hello there. You're the first creature I've heard in a while.", "I'm blind, you see. So when my flock hurriedly rushed away a few days ago, it was utter chaos! Too noisy... I couldn't make out their direction", "If you don't mind, could you point me in the direction the sun sets? Or, holler, rather?", "Oh! Was that healing magic? How sweet of you.", "Alas, there is nothing to heal, for nothing is broken. I was born with not born with eyes to see.", "I've had to train my ears instead. They have served me well.", "Until now, that is.", "*Sigh* ... Perhaps I wouldn't make it far even with directions.", "I don't mean to trouble you, but if you could somehow help me find my way, I would be very grateful indeed."]
var times = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$bgAnim.play("fadeIn")


func _on_PlyAnim_animation_finished(anim_name):
	if anim_name == "enter":
		$voice.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line = 1
		$PlyAnim.play("textCycle")
	elif anim_name == "textCycle":
		if line == 4:
			$PlyAnim.set_speed_scale(1)
			$PlyAnim.play("kiss")
		elif line == 10:
			$bgAnim.play("fadeOut")
		else:
			$voice.set_text(words[line])
			$PlyAnim.set_speed_scale(times[line])
			line += 1
			$PlyAnim.play("textCycle")
	elif anim_name == "kiss":
		$voice.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("textCycle")


func _on_bgAnim_animation_finished(anim_name):
	if anim_name == "fadeIn":
		$PlyAnim.play("enter")
	elif anim_name == "fadeOut":
		pass
		#Change scene here. 
