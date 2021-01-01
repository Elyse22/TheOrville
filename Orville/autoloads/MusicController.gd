extends Node

var basic_music = load ("res://Audio/Basic.wav")

func _ready():
	pass 
	
func play_music():
	
	$Music.stream = basic_music
	$Music.play()

