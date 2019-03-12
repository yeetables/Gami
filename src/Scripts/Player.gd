extends KinematicBody2D

var MAX_SPEED = 500
var ACC = 100
var velocity = Vector2()
var xspeed = 0
var animPlay = false
var DASH_SPEED = 300
var mousepos

var jforce = 500
var yspeed = 0
const UP = Vector2(0,-1)
var move_dir = Vector2(0,0)
#
#const hit_box_offset_flipped = Vector2(50,0)
#const hit_box_offset_normal = Vector2(0,0)

var dash = false
var count = 0
var landed = true

var timer_active = false
var time_start
var duration_ms
var start_value
const END_VALUE = 1


# Function to slow engine time
func slow_mode(duration = 2.25, strength = 0.99):
	time_start = OS.get_ticks_msec()
	duration_ms = duration*1000
	start_value = 1 - strength
	Engine.time_scale = start_value
	timer_active = true
	
	
func _physics_process(delta):
	
	if timer_active: 
		
		var current_time = OS.get_ticks_msec() - time_start
		var value = circl_ease_in(current_time, start_value, END_VALUE, duration_ms)
		if current_time >= duration_ms:
			timer_active = false
			value = END_VALUE
		Engine.time_scale = value
		yspeed = -100
		
		if Input.is_action_pressed("ui_lmb"):
			timer_active = false
			value = END_VALUE
			Engine.time_scale = value
			second_dash()
			
	# timer code done
	###################################################################################################

	if Input.is_key_pressed(KEY_1):
		MAX_SPEED = 450
		jforce = 500
#		ACC = 6
		print("1st gear")
	elif Input.is_key_pressed(KEY_2):
		MAX_SPEED = 540
		jforce = 530
#		ACC = 8
		print("2nd gear")
	elif Input.is_key_pressed(KEY_3):
		MAX_SPEED = 625
		jforce = 560
#		ACC = 10
		print("3rd gear")
	else:
		pass
		
	
	if Input.is_key_pressed(KEY_D):
		$Basic.set_flip_h(false) 
		if animPlay == false:
			$AnimationPlayer.play("FoxRun")
			animPlay = true
		if xspeed < 0:
			xspeed += 3 * ACC
		else:
			xspeed += ACC
			if xspeed > MAX_SPEED:
				xspeed = MAX_SPEED
	
	elif Input.is_key_pressed(KEY_A):
		$Basic.set_flip_h(true)
		if animPlay == false:
			$AnimationPlayer.play("FoxRun")
			animPlay = true
		if xspeed > 0:
			xspeed -= 3 * ACC
		else:
			xspeed -= ACC
			if xspeed < -MAX_SPEED:
				xspeed = -MAX_SPEED
				
	
	else:
		$AnimationPlayer.stop()
		animPlay = false
		if xspeed > ((ACC * 2) + 1):
			xspeed -= 2 * ACC
		elif xspeed < -16:
			xspeed += 2 * ACC
		else:
			xspeed = 0
			
	if Input.is_action_pressed("ui_lmb"):
		if not is_on_floor() and landed == true:
			dash = true
	
	#Jumping is gonna be a pain in the butt.
	#Start with an upwards speed, and constantly decrement.
	#While in the air you don't decelerate like you do on the ground.
	#But you can still use the keys to adjust trajectory, at a penalty. 
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
#        print("on floor:", is_on_floor())
		yspeed = jforce
		$jumpsound1.play()
#    if is_on_floor():
#        yspeed = 0

	# Dashing code
	if dash == true:
		# Checking for slowdown mode
		if Input.is_action_pressed("ui_rmb"):
			#get_tree().paused = true
			slow_mode()
			
		landed = false
		if xspeed > 0:
			xspeed = 900
			yspeed = 0
			count += 1
		elif xspeed < 0:
			xspeed = -900
			yspeed = 0
			count += 1
		else:
			dash = false
	
	if not is_on_floor() and dash == false:
		if yspeed > 0:
			yspeed -= 24
		elif yspeed <= 0:
			yspeed -= 18
			
	if count >= 15:
		dash = false
		count = 0
		
	if is_on_floor():
		landed = true
	
	#print(xspeed, yspeed)
	velocity.x = 1 * xspeed
	velocity.y = min(-1 * yspeed, 800)
	#print(velocity)
	move_and_slide(velocity, UP)
	
#	if $Basic.is_flipped_h():
#		$CollisionShape2D.set_position(hit_box_offset_flipped)
#	else:
#		$CollisionShape2D.set_position(hit_box_offset_normal)
			
func circl_ease_in(t, b, c, d):
	t /= d
	return -c * (sqrt(1 - t * t) - 1) + b
	
func second_dash():
	mousepos = get_viewport().get_mouse_position()
	var direction = (mousepos - self.global_position).normalized()
	print(direction)
	move_and_slide(direction * DASH_SPEED)
	direction = 0
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


