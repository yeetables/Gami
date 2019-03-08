extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	pass

func _on_rock_body_entered(body):
	print("someone entered")
	if not body.is_in_group("player"):
		queue_free()
	else:
		get_node("/root/World/sound/scream").play()
		Global.respawn_player()
		queue_free()