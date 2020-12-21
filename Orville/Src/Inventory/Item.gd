extends Node2D


onready var texture = $TextureRect


func _ready():
	if randi() % 2 == 0:
		texture.texture = load("res://Assets/Inventory/Items/Iron Sword.png")
	else:
		texture.texture = load("res://Assets/Inventory/Items/Slime Potion.png")
