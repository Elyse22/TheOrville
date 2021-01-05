extends HBoxContainer

func _update(value):
	$HSlider.value = value
	$Label.text = "Volume: " + str(int(100.0 * value)) + "%"
	AudioServer.set_bus_volume_db(_bus, linear2db(value))

func _ready():
	_update(db2linear(AudioServer.get_bus_volume_db(_bus)))

onready var _bus := AudioServer.get_bus_index("Master")
func _on_HSlider_value_changed(value):
	_update(value)
