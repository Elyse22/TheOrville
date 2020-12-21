extends Node2D


const slot_class = preload("res://Src/Inventory/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null


func _ready():
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
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - holding_item.texture.rect_size / 2











