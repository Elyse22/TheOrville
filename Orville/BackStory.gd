extends Node2D


func _on_DialogPlayer_stopped() -> void:
	get_tree().change_scene("res://Quarters.tscn")
