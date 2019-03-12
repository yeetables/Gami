extends KinematicBody2D

var MAX_SPEED = 500
var ACC = 6
var velocity = Vector2()
var xspeed = 0

var jforce = 501
var yspeed = 0
var count = 0

func _physics_process(delta):
	if Input.is_key_pressed(KEY_1):
		MAX_SPEED = 500
		jforce = 300
		ACC = 6
		print("1st gear")
	elif Input.is_key_pressed(KEY_2):
		MAX_SPEED = 450
		jforce = 650
		ACC = 8
		print("2nd gear")
	elif Input.is_key_pressed(KEY_3):
		MAX_SPEED = 600
		jforce = 800
		ACC = 10
		print("3rd gear")
	else:
		pass
	
	if Input.is_key_pressed(KEY_L):
		if xspeed < 0:
			xspeed += 3 * ACC
		else:
			xspeed += ACC
			if xspeed > MAX_SPEED:
				xspeed = MAX_SPEED
	
	elif Input.is_key_pressed(KEY_J):
		if xspeed > 0:
			xspeed -= 3 * ACC
		else:
			xspeed -= ACC
			if xspeed < -MAX_SPEED:
				xspeed = -MAX_SPEED
	
	else:
		if xspeed > ((ACC * 2) + 1):
			xspeed -= 2 * ACC
		elif xspeed < -16:
			xspeed += 2 * ACC
		else:
			xspeed = 0
	
	#Jumping is gonna be a pain in the butt.
	#Start with an upwards speed, and constantly decrement.
	#While in the air you don't decelerate like you do on the ground.
	#But you can still use the keys to adjust trajectory, at a penalty. 
	if Input.is_key_pressed(KEY_I): #and is_on_floor()
		count = 0
		yspeed = jforce
	elif yspeed != 0:
		count += 1
		yspeed = jforce - 7 * count
		print(count)
	
	
	#print(xspeed, yspeed)
	velocity.x = 1 * xspeed
	velocity.y = -1 * yspeed
	#print(velocity)
	move_and_slide(velocity)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
