extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	MusicController.play_briefing_music()
	
	
