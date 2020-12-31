extends Control


func _ready():
	check_sound_text()


func _on_Button_pressed():
	get_tree().change_scene("res://Title Screen.tscn")


func check_sound_text():
	if Data.sound:
		$CenterContainer/VBoxContainer/Label.text = "SOUND: ON"
	else:
		$CenterContainer/VBoxContainer/Label.text = "SOUND: OFF"


func toggle_sound():
	Data.sound = !Data.sound
	check_sound_text()
