extends Node2D


export var item_name = ""
export (Texture) var item_sprite
var player_around = false
var picked = false
var scanned = false

onready var progress_bar = $HUD/Control/Scanner/ProgressBar


func _ready():
	$HUD/Label.hide()
	$HUD/Control.hide()
	if item_name:
		$HUD/Control/Result/Label.text = item_name
	if item_sprite:
		$Sprite.texture = item_sprite
		$SpriteTexture.texture = item_sprite


func _on_Area2D_body_entered(body):
	if picked:
		return
	if body.name == "Player":
		if scanned:
			show_scan_result()
		else:
			$HUD/Label.show()
			player_around = true


func _on_Area2D_body_exited(body):
	if picked:
		return
	if body.name == "Player":
		if scanned:
			$HUD/Control.hide()
		else:
			$HUD/Label.hide()
			player_around = false


func _input(event):
	if picked:
		return
	if not player_around:
		return
	if event.is_action_pressed("talk"):
		$HUD/Label.hide()
		$HUD/Control.show()
		$Progress.start()


func progress():
	if progress_bar.value < 100:
		$HUD/Control/Scanner/ProgressBar.value += 1
	else:
		$Progress.stop()
		scanned = true
		show_scan_result()


func show_scan_result():
	$HUD/Control.show()
	$HUD/Control/Scanner.hide()
	$HUD/Control/Result.show()


func close():
	$HUD/Control/Scanner.show()
	$HUD/Control/Result.hide()
	$HUD/Control.hide()


func add_to_inventory():
	var data = []
	data.append(item_name)
	data.append($SpriteTexture.texture)
	Data.inventory.append(data)
	picked = true
	check()
	close()
	queue_free()


func check():
	if item_name == "Wrench":
		for item in Data.inventory:
			if item[0] == "Iron Coil":
				Data.can_talk_with["LeMarr"] = true
	if item_name == "Iron Coil":
		for item in Data.inventory:
			if item[0] == "Wrench":
				Data.can_talk_with["LeMarr"] = true

