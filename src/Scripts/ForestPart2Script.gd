extends Node2D

func _ready():
	Global.PLAYER_INSTANCE = $Player
	Global.DASH_ENABLED = true


func _on_stoneAnim_animation_finished(anim_name):
	Global.PLAYER_INSTANCE = null
	get_tree().change_scene("res://Scenes/Cutscenes/Bird2.tscn")
