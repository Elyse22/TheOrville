extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	Data.current_deck_f = filename
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	MusicController.play_briefing_music()
	Data.current_deck_b = "res://Deck B1.tscn"
	Data.return_to_the_orville = true
	Data.objective = "Go to the Briefing Room on Deck A"
	$HUD/DialogPlayer.play()
