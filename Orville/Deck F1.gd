extends Node2D



func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	
	


func _on_DialogPlayer_stopped():
	Data.take_items_to_lemarr = true
	Global.objective = "Ask Gordon to Take a Test Drive"
