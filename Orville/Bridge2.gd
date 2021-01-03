extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		pass#dialog_player.play()


func _on_DialogPlayer_stopped():
	get_tree().change_scene("res://Cutscene2.tscn")
