extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename


func _on_DialogPlayer_stopped():
	Data.spoke_with_isaac = true
	Global.objective = "Speak with LeMarr"
