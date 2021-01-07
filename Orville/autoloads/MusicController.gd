extends Node

var basic_music = load ("res://Audio/Basic.wav")
var space_music = load ('res://Audio/Space.wav')
var orville_music = load ('res://Audio/orville theme final wav.wav')
var moon_music = load ('res://Audio/Moon.wav')
var briefing_music = load ('res://Audio/Briefing.wav')

func _ready():
	pass

func play_music(stream):
	if $Music.stream != stream:
		$Music.stream = stream
		$Music.play()

func play_basic_music():
	play_music(basic_music)

func play_space_music():
	play_music(space_music)
	

func play_orville_music():
	play_music(orville_music)

func play_moon_music():
	play_music(moon_music)


func play_briefing_music():
	play_music(briefing_music)
