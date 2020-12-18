extends Node2D


onready var dialog_player = $HUD/DialogPlayer


func _ready():
	dialog_player.play("Quarters")


func entered_plant_1(body):
	if body.name == "Player":
		dialog_player.play("Plant_1")


func exited_pant_1(body):
	if body.name == "Player":
		if dialog_player.current_dialog == "Plant_1":
			dialog_player.stop()
