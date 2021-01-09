extends Control


func _ready():
	Data.objective = null

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://StarshipJ2857Bridge.tscn")
