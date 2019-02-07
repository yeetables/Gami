extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

#func _process(delta):
#    var velocity = Vector2()
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    if Input.is_action_pressed("ui_left"):
#        velocity.x -= 1
#        print("left pressed")
#    elif Input.is_action_pressed("ui_right"):
#        velocity.x += 1

const GRAVITY = 10# per frame
const UP = Vector2(0,-1)
const SPEED = Vector2(300, 300) # default speed
var velocity = Vector2()

func _physics_process(delta):
    # movement
    velocity.y += GRAVITY
    
    if Input.is_action_pressed("ui_right"):
        velocity.x = SPEED.x
        $Body/Basic.set_flip_h(false)
        
    elif Input.is_action_pressed("ui_left"):
        velocity.x = -SPEED.x
        $Body/Basic.set_flip_h(true)
    else:
        velocity.x = 0
        
    #TODO: remove this hack
    if Input.is_action_pressed("ui_up") and Global.CURRENT_FORM == Global.SQUIRREL:
        velocity.y = -SPEED.y

    if $Body.is_on_floor():
       
        if Input.is_key_pressed(KEY_SPACE):
            velocity.y = -SPEED.y
            
            if Input.is_action_pressed("ui_right"):
                velocity.x = SPEED.x * 2
            elif Input.is_action_pressed("ui_left"):
                velocity.x = -SPEED.x * 2
            else:
                velocity.x = 0     
        elif Input.is_action_just_released("ui_shift"):
            Global.switch_form()
            
    velocity = $Body.move_and_slide(velocity, UP)
    
    check_digging()
    
func check_digging():
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
#        print("digging")
        pass
        # TODO: change sprit here

        
        
    