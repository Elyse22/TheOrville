extends Node2D


func _ready():
	Data.current_deck_f = filename
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename


func _on_DialogPlayer_stopped():
	Data.spoke_with_lemarr = true
	Global.objective = "Speak with Bortus"
	Data.enable_portal("bortus_portal")
