extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FragmentArea_body_entered(body):
	if body.is_in_group('player'):
		Global.FRAGMENTS_R += 1
		get_node("/root/World/HUD/RedFrag").set_text(str(Global.FRAGMENTS_R))
		$Sprite.texture = null
		$Collected.play()
		
func _on_Collected_finished():
	queue_free()
