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
func inventory_has(item_name):
	for item in inventory:
		if item[0] == item_name:
			return true
	return false

var sound = true

var spoke_with_mercer = false

var spoke_with_isaac = false

var spoke_with_lemarr = false

var spoke_with_bortus = false

var take_items_to_lemarr = false

var spoke_with_gordon = false

var go_to_shuttlecraft = false

var find_tomolen = false

var find_blue_crystals = false

var return_to_tomolen = false

var return_to_the_orville = false

var go_to_briefing_room = false

var go_to_mess_hall = false

var current_deck_f = "res://Deck F.tscn"

var current_deck_b = "res://Deck B.tscn"

var disabled_portals = ["lab_portal","bortus_portal","bridge_portal"]
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
	find_tomolen = data.find_tomolen
	find_blue_crystals = data.find_blue_crystals
	return_to_tomolen = data.return_to_tomolen
	return_to_the_orville = data.return_to_the_orville
	go_to_briefing_room = data.go_to_briefing_room
	go_to_mess_hall = data.go_to_mess_hall
	current_deck_f = data.current_deck_f
	current_deck_b = data.current_deck_b
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
		'find_tomolen' : find_tomolen,
		'find_blue_crystals' : find_blue_crystals,
		'return_to_tomolen': return_to_tomolen,
		'return_to_the_orville' : return_to_the_orville,
		'go_to_briefing_room': go_to_briefing_room,
		'go_to_mess_hall': go_to_mess_hall,
		'current_deck_f': current_deck_f,
		'current_deck_b': current_deck_b,
		'disabled_portals': disabled_portals
	}
	var file = File.new()
	var error = file.open("user://save.dat", File.WRITE)
	if error == OK:
		file.store_var(data)
	file.close()
