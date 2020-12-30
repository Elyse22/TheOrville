extends Control

func _ready():
	check_sound_text()
	if Data.save_found:
		$Menu/Continue.disabled = false


func quit_game():
	get_tree().quit()


func check_sound_text():
	if Data.sound:
		$Menu/Sound.text = "SOUND: ON"
		$"Audio Effect/AudioStreamPlayer".playing = true
	else:
		$Menu/Sound.text = "SOUND: OFF"
		$"Audio Effect/AudioStreamPlayer".playing = false
	

func toggle_sound():
	Data.sound = !Data.sound
	check_sound_text()


func new_game():
	Data.save_found = false
	get_tree().change_scene("res://Src/CharacterCreation/CharacterCreation.tscn")


func continue_game():
	Data.load_game()
	get_tree().change_scene(Data.current_scene)


func options():
	get_tree().change_scene($Menu2/CenterRow/Buttons/OptionsButton.scene_to_load)
