# player.gd
extends KinematicBody2D

export var NORMAL_SPEED = 300
export var JUMP_SPEED = 10
export var GRAVITY = 15
export var JUMP_HEIGHT = 100
var MOTION_SPEED 
var worldNode
var velocity = Vector2(0,0)
var isJump

func _ready():
	set_physics_process(true)
	worldNode = get_tree().root.get_node("World")
	MOTION_SPEED = NORMAL_SPEED

func _physics_process(delta):
	control_loop(delta)
	movement_loop(delta)
	
func movement_loop(delta):
	var motion = velocity.normalized() * MOTION_SPEED
	
	var collision = move_and_collide(motion*delta)
	#if collision:
		#move_and_slide(motion)
	
func control_loop(delta):
	
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var JUMP    = Input.is_action_pressed("ui_up")
	
	#put movement and action conditions here
	if JUMP:
		jump()
		
	velocity.x = -int(LEFT) + int(RIGHT) # Prevents simulataneous movement to left and right
	velocity.y = -int(JUMP) # if jump is true, it turns it to false after calling jump()

func jump():
	if velocity.y <= -JUMP_HEIGHT:
		velocity.y = -JUMP_SPEED
	