extends Control

export (bool) var one_shot
export (Array, String) var speakers
export (Array, String) var dialogs
signal stopped
var index = -1

var disabled := false

func _ready():
	hide()


func play():
	if disabled:
		return
	if visible:
		return
	index = -1
	show()
	next_dialog()


func next_dialog():
	if index >= dialogs.size() - 1:
		stop()
		return
	if dialogs[index+1] == "":
		return
	index += 1

	if speakers.size() and speakers[index] and speakers[index].length():
		$Overlay/Container/Speaker/Name.text = speakers[index].replace("%p", Data.character.name)

		var file_name = str(speakers[index]).replace(" ", "")
		if ResourceLoader.exists("res://Assets/AllCharacters/Face/" + file_name + ".png"):
			$Overlay/Container/Speaker/Icon.texture = load("res://Assets/AllCharacters/Face/" + file_name + ".png")
		else:
			$Overlay/Container/Speaker/Icon.texture = null

		$Overlay/Container/Speaker.visible = true
	else:
		$Overlay/Container/Speaker.visible = false

	$Overlay/Container/Margin/Message/Text.text = dialogs[index].replace("%p", Data.character.name)
	$Tween.interpolate_property(
		$Overlay/Container/Margin/Message/Text, "percent_visible", 0,1,0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()


func _input(event):
	if event.is_action_pressed("ui_accept") and visible:
		next_dialog()


func tween_completed(object, key):
	pass # Replace with function body.


func stop():
	emit_signal("stopped")
	index = -1
	hide()
	if one_shot:
		disabled = true
	
	

