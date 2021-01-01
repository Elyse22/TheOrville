extends "res://Game/ReturnToTitle.gd"

func _ready():
	$CenterContainer/VBoxContainer/Volume/HSlider.value = db2linear(AudioServer.get_bus_volume_db(_bus))


onready var _bus := AudioServer.get_bus_index("Master")
func _on_Volume_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
