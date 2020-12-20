extends Node2D


onready var dialog_player = $HUD/DialogPlayer


func _ready():
	dialog_player.play()

