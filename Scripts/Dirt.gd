extends StaticBody2D
 
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

var PLAYER_ON_ME = false

func _on_Area2D_body_entered(body):
    if body.is_in_group("player"):
#        print("player comes")
        PLAYER_ON_ME = true

func _on_Area2D_body_exited(body):
    if body.is_in_group("player"):
#        print("player goes")
        PLAYER_ON_ME = false
        
func _physics_process(delta):
    #TODO: add condition: only check this if player form is FOX
    if PLAYER_ON_ME and Input.is_action_pressed("ui_down") and Global.CURRENT_FORM==Global.FOX:
        queue_free()