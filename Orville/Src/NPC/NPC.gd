extends KinematicBody2D

export var npc_name = ""
export (Texture) var npc_texture
export (Array, String) var dialogs

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
onready var dialog_player = $HUD/DialogPlayer

var velocity = Vector2.ZERO
var speed = 250
var walking = false
var player_around = false


func _ready():
	var speakers = []
	for i in dialogs.size():
		speakers.append(npc_name)
	dialog_player.speakers = speakers
	dialog_player.dialogs = dialogs
	$Popup.hide()
	$HUD/DialogPlayer.stop()
	if npc_texture:
		sprite.texture = npc_texture


func _process(_delta):
	handle_animation()


func _physics_process(_delta):
	if walking:
		velocity = move_and_slide(velocity, Vector2.UP)

func handle_animation():
	if velocity.x > 0:
		anim_player.play("move_right")
	elif velocity.x < 0:
		anim_player.play("move_left")
	else:
		if anim_player.current_animation == "move_right":
			anim_player.play("idle_right")
		elif anim_player.current_animation == "move_left":
			anim_player.play("idle_left")
	if velocity.y > 0:
		anim_player.play("move_down")
	elif velocity.y < 0:
		anim_player.play("move_up")
	else:
		if anim_player.current_animation == "move_down":
			anim_player.play("idle_down")
		elif anim_player.current_animation == "move_up":
			anim_player.play("idle_up")


func walk(direction):
	velocity = direction * speed
	walking = true


func stop_walking():
	walking = false



func player_around(body):
	if body.name == "Player":
		player_around = true
		$Popup.show()


func player_not_around(body):
	if body.name == "Player":
		player_around = false
		$Popup.hide()
		$HUD/DialogPlayer.stop()


func _input(event):
	if event.is_action_pressed("talk") and player_around:
		$HUD/DialogPlayer.play()


func dialog_player_stopped():
	$Popup.hide()
	player_around = false
