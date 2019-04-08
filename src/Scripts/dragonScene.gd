extends Node

var words = ["My child, you have made it.", "As you may have expected, it was I who was guiding you to this point.", "I am the guardian of the mountain and all its inhabitants. I am overjoyed to finally meet you. And yet...", "We do not have much time.", "You have collected the Stones of Vitality and Enhancement.", "The full power of the stones cannot be unleashed until all three are united. You still require the Stone of Wisdom to restore our home.", "I was once the keeper of the three stones. But my life is coming to an end, and I no longer have the strength to harness their essence.", "I scattered the two stones in hope that a willing creature would find them. When the animals all fled, I feared nobody would dare carry this burden.", "Yet not only have you endured, but prospered. You have far exceeded my expectations.", "Thank you for making my final moments ones of hope, joy, and...", "...relief.", "When I pass, the Stone of Wisdom will be released to you. It will not be long now. So I must ask, will you accept my gift?", "I am...pleased. I may now rest easy.", "It is time.", "The future of the mountain rests upon you now. Goodbye, my child."]
var times = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("start")
	$bgAnim.play("fadeIn")


func _on_PlyAnim_animation_finished(anim_name):
	if anim_name == "walkUp":
		#Do like, 2 sleep cycles or something here. 
		#They do the eye opening. 
		#Then this cutscene should basically be the same. 
		$Label.set_text(words[line])
		$PlyAnim.set_speed_scale(times[line])
		line += 1
		$PlyAnim.play("textCycle")
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
		pass
		#No idea


func _on_bgAnim_animation_finished(anim_name):
	if anim_name == "fadeIn":
		print("flag 1")
		$PlyAnim.play("walkUp")