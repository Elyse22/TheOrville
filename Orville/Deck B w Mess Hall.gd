extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	Data.go_to_mess_hall = true
	
	
	
	


func _on_Timer_timeout():
	$HUD/DialogPlayer1.play()


func _on_DialogPlayer_stopped():
	get_tree().change_scene("res://Game/Credits.tscn")


func _on_Timer2_timeout():
	$HUD/DialogPlayer2.play()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		MusicController.play_basic_music()
