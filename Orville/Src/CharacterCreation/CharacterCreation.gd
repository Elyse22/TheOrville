extends Control


var mustache = true
var hair = {
	"index": 1,
	"max": 9
}
var beard = {
	"index": 1,
	"max": 3
}
var skin = {
	"index": 1,
	"max": 5
}


func hair_color_changed(color):
	change_color("Hair", color)
	change_color("EyeBrows", color)


func beard_color_changed(color):
	change_color("Beard", color)


func mustache_color_changed(color):
	change_color("Mustache", color)


func pupil_color_changed(color):
	change_color("Pupil", color)


func shirt_color_changed(color):
	change_color("Shirt", color)


func change_color(property, color):
	get_node("Character/" + property).modulate = color


func toggle_mustache():
	mustache = !mustache
	get_node("Character/Mustache").visible = mustache
	if mustache:
		get_node("Screen/LeftMenu2/Mustache/Label").text = "Must"
	else:
		get_node("Screen/LeftMenu2/Mustache/Label").text = "OFF"


func next_hair():
	if hair.index == hair.max:
		hair.index = 0
	else:
		hair.index += 1
	update_hair()


func previous_hair():
	if hair.index == 0:
		hair.index = hair.max
	else:
		hair.index -= 1
	update_hair()


func update_hair():
	if hair.index == 0:
		get_node("Character/Hair").visible = false
	else:
		get_node("Character/Hair").visible = true
		get_node("Character/Hair").texture = load("res://Assets/AllCharacters/MainCharacter/Hair_" + str(hair.index) + ".png")
	get_node("Screen/LeftMenu2/Hair/Label").text = "Hair " + str(hair.index)


func next_beard():
	if beard.index == beard.max:
		beard.index = 0
	else:
		beard.index += 1
	update_beard()


func previous_beard():
	if beard.index == 0:
		beard.index = beard.max
	else:
		beard.index -= 1
	update_beard()


func update_beard():
	if beard.index == 0:
		get_node("Character/Beard").visible = false
	else:
		get_node("Character/Beard").visible = true
		get_node("Character/Beard").texture = load("res://Assets/AllCharacters/MainCharacter/Beard_" + str(beard.index) + ".png")
	get_node("Screen/LeftMenu2/Beard/Label").text = "Beard " + str(beard.index)


func next_skin():
	if skin.index == skin.max:
		skin.index = 1
	else:
		skin.index += 1
	update_skin()


func previous_skin():
	if skin.index == 1:
		skin.index = skin.max
	else:
		skin.index -= 1
	update_skin()


func update_skin():
	get_node("Character/Skin").texture = load("res://Assets/AllCharacters/MainCharacter/Skin_" + str(skin.index) + ".png")
	get_node("Screen/LeftMenu2/Skin/Label").text = "Skin " + str(skin.index)