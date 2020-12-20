extends Control

export (Array, String) var speakers
export (Array, String) var dialogs
signal stopped
var index = -1


func _ready():
	return
	play()


func play():
	index = -1
	show()
	next_dialog()


func next_dialog():
	if index >= speakers.size() - 1:
		stop()
		return
	if dialogs[index+1] == "":
		stop()
		return
	index += 1
	$Speaker/Name.text = speakers[index]
	$Message.text = dialogs[index]
	$Message.percent_visible = 0
	$Tween.interpolate_property(
		$Message, "percent_visible", 0,1,0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
	if speakers[index] != "MESSAGE":
		var file_name = str(speakers[index]).replace(" ", "")
		var file = File.new()
		if file.file_exists("res://Assets/AllCharacters/Face/" + file_name + ".png"):
			$Speaker/Icon.texture = load("res://Assets/AllCharacters/Face/" + file_name + ".png")
		else:
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
	emit_signal("stopped")
	index = -1
	hide()
