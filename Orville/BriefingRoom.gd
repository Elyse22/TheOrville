extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	Global.player_initial_map_position = Vector2(546.6,147.7)
