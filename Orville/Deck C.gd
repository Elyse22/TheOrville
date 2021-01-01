extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	if not Data.spoke_with_mercer:
		Global.objective = "Speak to Captain Mercer in his Office on Deck A"
