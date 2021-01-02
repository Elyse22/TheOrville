extends Node2D



func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Cutscene3.tscn")


func _on_MusicDetector_body_entered(body):
	MusicController.play_space_music()
