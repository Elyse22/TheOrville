extends VideoPlayer

func _ready():
	Data.objective = null

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Bridge3.tscn")


