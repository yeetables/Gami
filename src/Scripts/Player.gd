extends KinematicBody2D

var MAX_SPEED = 530
var ACC = 100
var velocity = Vector2()
var xspeed = 0
var animPlay = false
var mousepos

var jforce = 510
var yspeed = 0
const UP = Vector2(0,-1)
var move_dir = Vector2(0,0)

var dash = false
var count = 0
var landed = true

var direction = 0

var JUMPING = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$DeathTimer.start()
	
func _physics_process(delta):
	
	if Global.CAN_MOVE == true:
		
		if Input.is_key_pressed(KEY_R):
			respawn_R()
		
		if Input.is_action_pressed("ui_right"):
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
		
		elif Input.is_action_pressed("ui_left"):
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
			if not is_on_floor() and landed == true and Global.DASH_ENABLED:
				dash = true
		
		if is_on_floor():
			if Input.is_action_just_pressed("space"):
				$jumpsound1.play() 
				yspeed = jforce
	
		# Dashing code
		if dash == true:
				
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
			JUMPING = true
			
			if yspeed > 0:
				yspeed -= 24
			elif yspeed <= 0:
	#			ACC = 200
				MAX_SPEED = 550
				yspeed -= 15
				
		if count >= 15:
			dash = false
			count = 0
			
		if is_on_floor() and JUMPING:
			ACC = 100
			MAX_SPEED = 530
			JUMPING = false
			
		if is_on_floor():
			landed = true
		
		#print(xspeed, yspeed)
		velocity.x = 1 * xspeed
		# control falling speed
		velocity.y = min(-1 * yspeed, 2000)
	
		move_and_slide(velocity, UP)
	

func respawn_R():
	Global.respawn_player()
	
func _on_DeathTimer_timeout():
	Global.CAN_MOVE = true
