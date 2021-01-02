extends Node

var basic_music = load ("res://Audio/Basic.wav")
var space_music = load ('res://Audio/Space.wav')
var orville_music = load ('res://Audio/orville theme final wav.wav')
var moon_music = load ('res://Audio/Moon.wav')
var briefing_music = load ('res://Audio/Briefing.wav')

func _ready():
	pass

func play_basic_music():
	$Music.stream = basic_music
	$Music.play()

func play_space_music():
	$Music.stream = space_music
	$Music.play()
	

func play_orville_music():
	$Music.stream = orville_music
	$Music.play()

func play_moon_music():
	$Music.stream = moon_music
	$Music.play()


func play_briefing_music():
	$Music.stream = briefing_music
	$Music.play()
