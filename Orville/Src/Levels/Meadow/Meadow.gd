extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	
	
	
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$HUD/DialogPlayer.play()
		
	


func _on_DialogPlayer_stopped():
	$HUD/DialogPlayer.play()
	Data.find_tomolen = true
	Global.objective = "Find 3 Blue Crystals on Nearby Moon"


func _on_DialogPlayer_stopped2():
	for npc in [$YSort/NPC, $YSort/NPC2, $YSort/NPC3]:
		npc.walk_custom_path()
		npc.reverse_path()
		npc.connect("path_finished", npc, "custom_animation", ["disappear"])
		npc.get_node("AnimationPlayer").connect("animation_finished", self, "_handle_anim", [npc])

func _handle_anim(anim, npc):
	if anim == "disappear":
		npc.queue_free()

