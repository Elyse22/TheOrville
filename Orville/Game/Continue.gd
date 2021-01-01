extends Node

func _ready():
	Data.load_game()
	get_tree().change_scene(Data.current_scene)
