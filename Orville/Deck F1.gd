extends Node2D



func _ready():
	Data.current_deck_f = filename
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	
	


func _on_DialogPlayer_stopped():
	Data.take_items_to_lemarr = true
	Global.objective = "Speak to Gordon on the Bridge on Deck A"
	Data.enable_portal("bridge_portal")
