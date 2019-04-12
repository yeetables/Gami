extends Node

func _ready():
	Global.PLAYER_INSTANCE = $Player
	Global.DASH_ENABLED = false


# when the player reaches the end
func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		Global.PLAYER_INSTANCE = null
		Global.Level1Finished = true
