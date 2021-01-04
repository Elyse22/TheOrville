extends Area2D

var player_inside

func _process(delta):
	if player_inside and not player_inside.sitting:
		$Popup.show()
	else:
		$Popup.hide()

func _on_SitTrigger_body_entered(body):
	if body is Player:
		player_inside = body


func _on_SitTrigger_body_exited(body):
	if body is Player:
		player_inside = null

func _input(event):
	if event.is_action_pressed("sit") and player_inside:
		player_inside.sitting = not player_inside.sitting
		player_inside.direction = "down"
		player_inside.global_position = global_position
