extends Node2D


func _ready():
	if Data.current_scene == filename:
		$Player.position = Data.player_position
	Data.current_scene = filename
	
	if Data.take_items_to_lemarr:
		$YSort/NPC2.queue_free()
