extends Area2D

var player_inside

func _process(delta):
	if player_inside and not player_inside.sitting:
		$Popup.show()
	else:
		$Popup.hide()

func _on_RoomTrigger_body_entered(body):
	if body is Player:
		player_inside = body


func _on_RoomTrigger_body_exited(body):
	if body is Player:
		player_inside = null
		

func _on_RoomTrigger2_body_entered(body):
	if body is Player:
		player_inside = body


func _on_RoomTrigger2_body_exited(body):
	if body is Player:
		player_inside = null


func _on_RoomTrigger3_body_entered(body):
	if body is Player:
		player_inside = body


func _on_RoomTrigger3_body_exited(body):
	if body is Player:
		player_inside = null


func _on_RoomTrigger4_body_entered(body):
	if body is Player:
		player_inside = body


func _on_RoomTrigger4_body_exited(body):
	if body is Player:
		player_inside = null


func _on_RoomTrigger5_body_entered(body):
	if body is Player:
		player_inside = body


func _on_RoomTrigger5_body_exited(body):
	if body is Player:
		player_inside = null
