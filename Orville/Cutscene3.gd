extends Control


func _ready():
	Global.objective = null

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://StarshipJ2857Bridge.tscn")
