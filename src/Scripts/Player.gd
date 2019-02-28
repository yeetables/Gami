extends KinematicBody2D

var MAX_SPEED = 500
var ACC = 8
var velocity = Vector2()
var xspeed = 0
var animPlay = false

var jforce = 377
var yspeed = 0
const UP = Vector2(0,-1)

func _physics_process(delta):
    if Input.is_key_pressed(KEY_1):
        MAX_SPEED = 400
        jforce = 400
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
    
    elif Input.is_key_pressed(KEY_J):
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
    
    #Jumping is gonna be a pain in the butt.
    #Start with an upwards speed, and constantly decrement.
    #While in the air you don't decelerate like you do on the ground.
    #But you can still use the keys to adjust trajectory, at a penalty. 
    if Input.is_key_pressed(KEY_I) and is_on_floor():
#        print("on floor:", is_on_floor())
        yspeed = jforce
        
#    if is_on_floor():
#        yspeed = 0
    
    if not is_on_floor():
        yspeed -= 8
        if yspeed <= 0:
            yspeed -= 16
    
    #print(xspeed, yspeed)
    velocity.x = 1 * xspeed
    velocity.y = -1 * yspeed
    #print(velocity)
    move_and_slide(velocity, UP)

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass


