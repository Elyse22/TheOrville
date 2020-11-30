extends Node2D

onready var AnimationPlay = $AnimationPlayer


func _ready():
	AnimationPlay.play("Idle")
