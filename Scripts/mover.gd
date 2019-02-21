extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const MAX_SPEED = 500
const ACC = 5

var velocity = Vector2()

var speed = 0


func _physics_process(delta):
	if Input.is_key_pressed(KEY_L):
		if speed < 0:
			speed += 4 * ACC
		else:
			speed += ACC
			if speed > MAX_SPEED:
				speed = MAX_SPEED
	
	elif Input.is_key_pressed(KEY_J):
		if speed > 0:
			speed -= 4 * ACC
		else:
			speed -= ACC
			if speed < -MAX_SPEED:
				speed = -MAX_SPEED
	
	else:
		if speed > 16:
			speed -= 3 * ACC
		elif speed < -16:
			speed += 3 * ACC
		else:
			speed = 0
	
	print(speed)
	velocity.x = 1
	velocity = velocity.normalized() * speed
	#print(velocity)
	move_and_slide(velocity)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
