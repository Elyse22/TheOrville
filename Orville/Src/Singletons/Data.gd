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
	"mustache_style": "res://Assets/AllCharacters/MainCharacter/Mustache.png"
}

var can_talk_with = {
	"LeMarr": true
}

var current_scene = ""
var player_position = Vector2.ZERO
var npc_dialog_index = {}

var spawn_wrench_iron_coil = false

var inventory = []

var sound = true

var spoke_with_mercer = false

var spoke_with_isaac = false

var spoke_with_lemarr = false

var spoke_with_bortus = false

var take_items_to_lemarr = false

var spoke_with_gordon = false

var go_to_shuttlecraft = false

var current_deck_f = "res://Deck F.tscn"

var disabled_portals = ["lab_portal"]
func enable_portal(id: String):
	disabled_portals.erase(id)
func disable_portal(id: String):
	disabled_portals.erase(id)
	disabled_portals.push_back(id)

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
	spoke_with_mercer = data.spoke_with_mercer
	spoke_with_isaac = data.spoke_with_isaac
	spoke_with_lemarr = data.spoke_with_lemarr
	spoke_with_bortus = data.spoke_with_bortus
	take_items_to_lemarr = data.take_items_to_lemarr
	spoke_with_gordon = data.spoke_with_gordon
	go_to_shuttlecraft = data.go_to_shuttlecraft
	current_deck_f = data.current_deck_f
	disabled_portals = data.disabled_portals
	file.close()

func save_game():
	var data = {
		'character': character,
		'can_talk_with': can_talk_with,
		'current_scene': current_scene,
		'player_position': player_position,
		'npc_dialog_index': npc_dialog_index,
		'spawn_wrench_iron_coil': spawn_wrench_iron_coil,
		'inventory': inventory,
		'sound': sound,
		'spoke_with_mercer': spoke_with_mercer,
		'spoke_with_isaac': spoke_with_isaac,
		'spoke_with_lemarr': spoke_with_lemarr,
		'spoke_with_bortus': spoke_with_bortus,
		'take_items_to_lemarr': take_items_to_lemarr,
		'spoke_with_gordon': spoke_with_gordon,
		'go_to_shuttlecraft': go_to_shuttlecraft,
		'current_deck_f': current_deck_f,
		'disabled_portals': disabled_portals
	}
	var file = File.new()
	var error = file.open("user://save.dat", File.WRITE)
	if error == OK:
		file.store_var(data)
	file.close()
	$Message.text = "GAME SAVED!"
	yield(get_tree().create_timer(3), "timeout")
	$Message.text = ""
