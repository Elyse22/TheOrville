extends Node2D

func _on_DialogPlayer_stopped() -> void:
	get_tree().change_scene("res://Quarters.tscn")

func _ready():
	MusicController.play_basic_music()
	$DialogPlayer.play()

