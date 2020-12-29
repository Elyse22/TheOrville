extends Node

var character = {
	"name": "",
	"hair_color": Color.white,
	"beard_color": Color.white,
	"mustache_color": Color.white,
	"pupil_color": Color.white,
	"shirt_color": Color.white,
	"hair_style": load("res://Assets/AllCharacters/MainCharacter/Hair_1.png"),
	"skin_style": load("res://Assets/AllCharacters/MainCharacter/Skin_1.png"),
	"beard_style": load("res://Assets/AllCharacters/MainCharacter/Beard_1.png"),
	"mustache_style": false,
}

var can_talk_with = {
	"LeMarr": true
}

var spawn_wrench_iron_coil = false

var inventory = []
