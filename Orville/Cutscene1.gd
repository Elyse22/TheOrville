extends VideoPlayer



func _ready():
	Global.objective = null

func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Bridge2.tscn")
