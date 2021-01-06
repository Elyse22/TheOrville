extends Node2D

onready var dialog_player = $HUD/DialogPlayer



func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	Global.player_initial_map_position = Vector2(546.6,147.7)




func _on_Timer_timeout():
	$HUD/DialogPlayer.play()
	
	
	


func _on_DialogPlayer_stopped():
	Data.go_to_briefing_room = true
	Global.objective = "Go to Mess Hall on Deck B"
