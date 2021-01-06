extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	
	
	

func _on_DialogPlayer_stopped():
	$HUD/DialogPlayer.play()
	Data.find_blue_crystals = true
	Global.objective = "Return to The Orville"


func _on_DialogPlayer_stopped2():
	$YSort/NPC.walk_custom_path()
	$YSort/NPC.reverse_path()
	$YSort/NPC2.walk_custom_path()
	$YSort/NPC2.reverse_path()
	$YSort/NPC3.walk_custom_path()
	$YSort/NPC3.reverse_path()
