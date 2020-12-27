extends Node2D


onready var texture = $TextureRect
var item_name = ""


func _ready():
	pass
#	if randi() % 2 == 0:
#		texture.texture = load("res://Assets/Inventory/Items/Iron Sword.png")
#	else:
#		texture.texture = load("res://Assets/Inventory/Items/Slime Potion.png")


func set_item_data(new_name, new_texture):
	texture.texture = new_texture
	item_name = new_name
