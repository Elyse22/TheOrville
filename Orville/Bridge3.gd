extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	


func _on_DialogPlayer_stopped():
	Data.spoke_with_gordon = true
	Global.objective = "Join the Away Team on the Shuttlecraft"


func _on_Portal_body_entered(body):
	Data.current_deck_f = "res://Deck F2.tscn"


func _on_Timer_timeout():
	$HUD/DialogPlayer.play()
