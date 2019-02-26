extends Area2D

var START_CRUMBLING = false

func _on_crumbling_body_entered(body):
    if body.is_in_group("player") and not START_CRUMBLING:
        START_CRUMBLING = true
        
var count = 0
var blink_frames = 30
var blink_times = 3
func _physics_process(delta):
    if START_CRUMBLING:
        count += 1
        var step = float(count) /  blink_frames # this should be an integer
        if fmod(step, 2) == 0:
            hide()
        elif fmod(step, 2) == 1:
            show()
        
        if count >= 2*blink_times*blink_frames:
            START_CRUMBLING = false
            queue_free()
        
