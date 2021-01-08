extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	if not Data.spoke_with_bortus or Data.take_items_to_lemarr or Data.inventory_has("Iron Coil"):
		$YSort/Item.queue_free()
	
	if Data.take_items_to_lemarr:
		$YSort/NPC2.queue_free()
	
	if Data.spoke_with_mercer:
		$YSort/NPC.queue_free()
	else:
		Global.objective = "Speak to the Captain in his office on Deck A"


