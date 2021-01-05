extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	if Data.spoke_with_mercer:
		$YSort/NPC.queue_free()
	else:
		Global.objective = "Speak to Captain Mercer"
