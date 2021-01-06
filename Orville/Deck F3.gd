extends Node2D


func _ready():
	Data.current_deck_f = filename
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	MusicController.play_briefing_music()
	Data.current_deck_b = "res://Deck B1.tscn"
	Data.return_to_the_orville = true
	Global.objective = "Go to Briefing Room on Deck A"
	
