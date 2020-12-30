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
	var data = {
		'character': Data.character,
		'can_talk_with': Data.can_talk_with,
		'current_scene': Data.current_scene,
		'player_position': Data.player_position,
		'npc_dialog_index': Data.npc_dialog_index,
		'spawn_wrench_iron_coil': Data.spawn_wrench_iron_coil,
		'inventory': Data.inventory,
		'sound': Data.sound
	}
	var file = File.new()
	var error = file.open("user://save.dat", File.WRITE)
	if error == OK:
		file.store_var(data)
	file.close()
	$Message.text = "GAME SAVED!"
	yield(get_tree().create_timer(3), "timeout")
	$Message.text = ""


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		Data.player_position = get_parent().get_parent().position
