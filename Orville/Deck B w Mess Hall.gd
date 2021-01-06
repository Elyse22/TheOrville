extends Node2D

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	Data.go_to_mess_hall = true
	
	
	
	
