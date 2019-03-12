extends Area2D

var START_CRUMBLING = false
var blink_frames = 10
var blink_times = 3
var wait_frames = 300
var wait = false

func _on_crumbling_body_entered(body):
	if body.is_in_group("player") and not START_CRUMBLING:
		START_CRUMBLING = true
		count += 5
		
var count = 0
func _physics_process(delta):
	if START_CRUMBLING:
		get_node("/root/World/Music/sound/rock2").play()
		var step = float(count) /  blink_frames # this should be an integer
		if fmod(step, 2) == 0:
			hide()
		elif fmod(step, 2) == 1:
			show()
		
		if count >= 2*blink_times*blink_frames:
			START_CRUMBLING = false
			disable()
			wait = true
		count += 1
		
	if wait:
		
		if count >= wait_frames:
			wait = false
			count = 0
			enable()
			
		count += 1
		
func disable():
	hide()
	get_node("crumbling_base/CollisionShape2D").disabled = true
	get_node("CollisionShape2D").disabled = true
	
func enable():
	show()
	get_node("crumbling_base/CollisionShape2D").disabled = false
	get_node("CollisionShape2D").disabled = false