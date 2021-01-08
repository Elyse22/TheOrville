extends Node2D


onready var dialog_player = $HUD/DialogPlayer


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename



func _on_Area2D_body_entered(body):
	if body.name == "Player" and not Data.spoke_with_mercer:
		$HUD/DialogPlayer.play()
