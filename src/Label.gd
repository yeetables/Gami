extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var t = Timer.new()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _process(delta):
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	if Cutscene.lock == true:
		self.text = "Wake up."
		t.start()
		yield(t, "timeout")
		self.text = "The mountain needs you."
		t.start()
		yield(t, "timeout")
		Cutscene.lock = false