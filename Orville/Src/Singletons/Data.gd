extends Node

var character = {
	"name": "",
	"hair_color": Color.white,
	"beard_color": Color.white,
	"mustache_color": Color.white,
	"pupil_color": Color.white,
	"shirt_color": Color.white,
	"hair_style": "res://Assets/AllCharacters/MainCharacter/Hair_1.png",
	"skin_style": "res://Assets/AllCharacters/MainCharacter/Skin_1.png",
	"beard_style": "res://Assets/AllCharacters/MainCharacter/Beard_1.png",
	"mustache_style": false,
}

var can_talk_with = {
	"LeMarr": true
}

var current_scene = ""
var player_position = Vector2.ZERO
var npc_dialog_index = {}

var spawn_wrench_iron_coil = false

var inventory = [""]

var sound = true

var save_found = false


func _ready():
	var file = File.new()
	if !file.file_exists("user://save.dat"):
		return
	file.open("user://save.dat", File.READ)
	var data = file.get_var()
	sound = data.sound
	file.close()
	save_found = true


func load_game():
	var file = File.new()
	file.open("user://save.dat", File.READ)
	var data = file.get_var()
	character = data.character
	print(character)
	can_talk_with = data.can_talk_with
	current_scene = data.current_scene
	player_position = data.player_position
	npc_dialog_index = data.npc_dialog_index
	spawn_wrench_iron_coil = data.spawn_wrench_iron_coil
	inventory = data.inventory
	sound = data.sound
	file.close()
