extends Node2D


onready var dialog_player = $HUD/DialogPlayer


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	dialog_player.stop()


func ed_dialog():
	dialog_player.dialogs[0] = "Commander " + Data.character.name + ", it's Captain Ed Mercer. Come see me in my office immediately."
	dialog_player.play()


func body_entered(body):
	if body.name == "Player":
		ed_dialog()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		dialog_player.play()
