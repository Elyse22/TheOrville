extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename

	if Data.spoke_with_isaac:
		$YSort/NPC.trigger_talk = false
	if Data.take_items_to_lemarr:
		$YSort/NPC.queue_free()

func _on_DialogPlayer_stopped():
	Data.spoke_with_isaac = true
	Data.objective = "Speak with LeMarr in Engineering on Deck F"
