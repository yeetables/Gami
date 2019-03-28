extends Node2D

func _ready():
	Global.PLAYER_INSTANCE = $Player
	Global.DASH_ENABLED = true