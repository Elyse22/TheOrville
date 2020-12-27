extends Node2D

var item_class = preload("res://Src/Inventory/Item.tscn")
const slot_class = preload("res://Src/Inventory/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null
var inventory = []


func _ready():
	hide()
	for inventory_slot in inventory_slots.get_children():
		inventory_slot.connect("gui_input", self, "slot_gui_input", [inventory_slot])


func slot_gui_input(event: InputEvent, slot: slot_class):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					slot.put_into_slot(holding_item)
					holding_item = null
				else:
					var temp_item = slot.item
					slot.pick_from_slot()
					temp_item.global_position = event.global_position - holding_item.texture.rect_size / 2
					slot.put_into_slot(holding_item)
					holding_item = temp_item
			elif slot.item:
				holding_item = slot.item
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position() - holding_item.texture.rect_size / 2


func _input(event):
	if event.is_action_pressed("Inventory"):
		show_inventory()
	if event.is_action_released("Inventory"):
		hide()
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - holding_item.texture.rect_size / 2


func show_inventory():
	update_inventory()
	show()


func update_inventory():
	for i in range(inventory.size(), Data.inventory.size()):
		inventory.append(Data.inventory[i])
		var item = item_class.instance()
		add_child(item)
		var item_name = Data.inventory[i][0]
		var item_texture = Data.inventory[i][1]
		item.set_item_data(item_name, item_texture)
		for slot in inventory_slots.get_children():
			if not slot.item:
				slot.put_into_slot(item)
				break

