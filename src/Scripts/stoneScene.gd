extends Node

var words = ["The Stone of Vitality offers sustenance and strength, and heals all injuries.", "The power of the stone is now yours. You may use it how you see fit. Indeed, I sense there is a creature nearby that could benefit from your newfound abilities."]
var times = [1, 0.6]
var line = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$cycle.play("fadeIn")
	$bg.seek(14.82)
func _physics_process(delta):
	# advance to the end of this when we are playing "Words"
	# just so that they won't accidentally skip a line
	if $cycle.get_current_animation() == "textCycle" and $cycle.is_playing():
		$HUD/nextline.visible = true
	else:
		$HUD/nextline.visible = false
		
	if Input.is_action_just_pressed("ui_lmb") and \
	$cycle.get_current_animation_position() >= 0.5 and \
	$cycle.get_current_animation() == "textCycle":
		
		var totalTime = $cycle.get_current_animation_length()
		var speed = $cycle.get_speed_scale()
		$cycle.advance(totalTime/speed)
		
	if Input.is_action_just_pressed("ui_skip"):
		get_tree().change_scene("res://Scenes/Cutscenes/Deer.tscn")
		
func _on_cycle_animation_finished(anim_name):
	if anim_name == "fadeIn":
		$cycle.set_speed_scale(times[line])
		$Label.set_text(words[line])
		line += 1
		$cycle.play("textCycle")
	elif anim_name == "textCycle":
		if line == 2:
			$cycle.set_speed_scale(1)
			$cycle.play("fadeOut")
		else:
			$cycle.set_speed_scale(times[line])
			$Label.set_text(words[line])
			line += 1
			$cycle.play("textCycle")
	elif anim_name == "fadeOut":
		#Change scene
		get_tree().change_scene("res://Scenes/Cutscenes/Deer.tscn")