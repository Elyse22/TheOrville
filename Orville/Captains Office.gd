extends Node2D


func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	if Data.spoke_with_mercer:
		$YSort/NPC.trigger_talk = false


func _on_DialogPlayer_stopped():
	Data.spoke_with_mercer = true
	Data.enable_portal("lab_portal")
	Global.objective = "Speak with Isaac in Science Lab on Deck B"

	if Data.spoke_with_isaac:
		$YSort/NPC.queue_free()
