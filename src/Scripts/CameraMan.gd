extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
var target = Vector2()
var speed = 500

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT) == false:

		target = Global.PLAYER_POS
		if (target.y > 300): # if the player is at the bottom, don't the camera go down there
			target.y = 300 # if change this value, need to change Global.move_camera() function as well

		velocity = (target - position).normalized() * speed
		if(target - position).length() > 5:
			move_and_slide(velocity)
		if(target - position).length() < 500 and (target - position).length() > 5:
			velocity = (target - position).normalized() * (target-position).length()
			move_and_slide(velocity)
			#position = target
	else:
		#print("camera")
		#velocity.y = 0
		#velocity.x = -1
		#velocity = velocity.normalized() * speed
		#move_and_slide(velocity)
		pass