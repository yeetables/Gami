extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var part2_started = false
func _physics_process(delta):
	if not $bg1.is_playing() and not part2_started:
		part2_started = true
		$bg2.play()
		