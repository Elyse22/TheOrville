extends VBoxContainer


func _ready():
	check_sound_text()
	hide()


func toggle_sound():
	Data.sound = !Data.sound
	check_sound_text()


func check_sound_text():
	if Data.sound:
		$Sound.text = "SOUND: ON"
	else:
		$Sound.text = "SOUND: OFF"


func back():
	get_tree().paused = false
	hide()


func quit():
	get_tree().quit()


func save_game():
	Data.save_game()


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		Data.player_position = get_parent().get_parent().position
