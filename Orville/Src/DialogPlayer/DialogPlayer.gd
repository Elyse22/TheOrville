extends Control

export (Dictionary) var dialogs = {}
var index = -1
var message_list = []
var speaker_list = []
var current_dialog = ""


func _ready():
	return
	print(dialogs)
	play("Quarters")


func play(dialog):
	show()
	current_dialog = dialog
	var dialogs_list = []
	for key in dialogs[dialog].keys():
		var message = key + ": " + dialogs[dialog][key]
		print(message)
		dialogs_list.append(message)
		speaker_list.append(key)
		message_list.append(dialogs[dialog][key])
	next_dialog()


func next_dialog():
	if index >= speaker_list.size() - 1:
		hide()
		return
	index += 1
	$Speaker/Name.text = speaker_list[index]
	$Message.text = message_list[index]
	$Message.percent_visible = 0
	$Tween.interpolate_property(
		$Message, "percent_visible", 0,1,0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
	if speaker_list[index] != "MESSAGE":
		var file_name = str(speaker_list[index]).replace(" ", "")
		#$Speaker/Icon.texture = load("res://Assets/AllCharacters/Characters/" + file_name + ".png")
		$Speaker/Icon.texture = null
	else:
		$Speaker/Icon.texture = null
		$Speaker/Name.text = ""

func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_dialog()


func tween_completed(object, key):
	pass # Replace with function body.


func stop():
	hide()
