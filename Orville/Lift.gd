extends Area2D


func _ready():
	$HUD/VBoxContainer.hide()
	for button in $HUD/VBoxContainer.get_children():
		button.connect("pressed", self, "lift", [button.name])
	if has_node("HUD/VBoxContainer/" + get_parent().name):
		get_node("HUD/VBoxContainer/" + get_parent().name).disabled = true


func player_entered(body):
	if body.name == "Player":
		$HUD/VBoxContainer.show()


func player_exited(body):
	if body.name == "Player":
		$HUD/VBoxContainer.hide()


func lift(button_name):
	if button_name == "DeckB":
		get_tree().change_scene("res://Deck B.tscn")
	elif button_name == "DeckC":
		get_tree().change_scene("res://Deck C.tscn")
	else:
		get_tree().change_scene("res://Deck F.tscn")
