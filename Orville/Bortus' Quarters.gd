extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename


	if Data.take_items_to_lemarr:
		$YSort/NPC.queue_free()

#func _process(_delta):
#	if not get_node("IronCoil") == null and not get_node("Wrench") == null:
#		$IronCoil.visible = Data.spawn_wrench_iron_coil
#		$Wrench.visible = Data.spawn_wrench_iron_coil


func _on_DialogPlayer_stopped():
	Data.current_deck_f = "res://Deck F1.tscn"
	Data.spoke_with_bortus = true
	Data.objective = "Find Wrench and Iron Coil"
