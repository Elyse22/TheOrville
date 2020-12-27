extends Panel


var default_tex = preload("res://Assets/Inventory/item_slot_default_background.png")
var empty_tex = preload("res://Assets/Inventory/item_slot_empty_background.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var item_class = preload("res://Src/Inventory/Item.tscn")
var item = null


func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	refresh_style()
	return
	if randi() % 2 == 0:
		item = item_class.instance()
		add_child(item)


func refresh_style():
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set("custom_styles/panel", default_style)


func pick_from_slot():
	remove_child(item)
	var inventory_node = find_parent("Inventory")
	inventory_node.add_child(item)
	item = null
	refresh_style()


func put_into_slot(new_item):
	item = new_item
	item.position = Vector2.ZERO
	var inventory_node = find_parent("Inventory")
	inventory_node.remove_child(item)
	add_child(item)
	refresh_style()













