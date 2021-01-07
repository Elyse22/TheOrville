extends Control

onready var text = $Label

func _ready():
	text.rect_position.y = get_viewport().size.y
	MusicController.play_orville_music()

func _process(delta):
	text.rect_position.y -= 50.0 * delta
	if text.rect_position.y < -rect_size.y:
		get_tree().quit()
