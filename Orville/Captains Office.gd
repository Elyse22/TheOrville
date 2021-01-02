extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	


func _on_DialogPlayer_stopped():
	Data.spoke_with_mercer = true
	Data.enable_portal("lab_portal")
	Global.objective = "Speak with Isaac"
