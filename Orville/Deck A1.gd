extends Node2D


func _ready():
	if Data.current_scene == filename:
		$Player.position = Data.player_position
	Data.current_scene = filename
	
	
