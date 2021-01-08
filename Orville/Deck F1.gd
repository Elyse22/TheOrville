extends Node2D

onready var dialog_player = $HUD/DialogPlayer


func _ready():
	Data.current_deck_f = filename
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename


func _process(_delta):
	if not Data.take_items_to_lemarr:
		if Data.inventory_has("Wrench") and Data.inventory_has("Iron Coil"):
			Global.objective = "Take Wrench and Iron Coil to LeMarr"
		else:
			Global.objective = "Find Wrench and Iron Coil"


func _on_BranchingNPC_dialogue_finished(index):
	if index == 1:
		Data.take_items_to_lemarr = true
		Global.objective = "Speak to Gordon on the Bridge on Deck A"
		Data.enable_portal("bridge_portal")
