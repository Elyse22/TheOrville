extends Node2D

onready var dialog_player = $HUD/DialogPlayer

func _ready():
	if Data.current_scene == filename:
		$YSort/Player.position = Data.player_position
	Data.current_scene = filename
	MusicController.play_moon_music()

func _process(_delta):
	if not Data.take_items_to_lemarr and not Data.find_blue_crystals:
		if Data.inventory_has("Blue Crystal1") and Data.inventory_has("Blue Crystal2") and Data.inventory_has("Blue Crystal3"):
			Global.objective = "Speak with Captain Mercer"
		else:
			Global.objective = "Find 3 Blue Crystals"


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Cutscene5.tscn")



func _on_BranchingNPC_dialogue_finished(index):
	if index == 1:
		$HUD/DialogPlayer.play()
		Data.find_blue_crystals = true
		Global.objective = "Return to Tomolen"
	if index == 0:
		Global.objective = "Find 3 Blue Crystals"


func _on_Timer_timeout():
	$HUD/DialogPlayer2.play()

