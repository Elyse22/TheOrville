extends KinematicBody2D

export var npc_name = ""
export (Texture) var npc_texture
export (Array, String) var dialogs
export var trigger_talk = true

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
onready var dialog_player = $HUD/DialogPlayer

var velocity = Vector2.ZERO
var speed = 50
var walking = false
var player_around = false
var path
var walking_on_path = false
export var dialog_index = -1
var can_talk = true
export var move_random: bool = true

func set_path(new_path):
	path = new_path
	walking_on_path = true


func set_dialogs():
	if dialogs.size() == 0:
		return
#	if dialog_index >= dialogs.size() -1:
#		return
#	dialog_index += 1
	var speakers = []
	for i in dialogs.size():
		speakers.append(npc_name)
	dialog_player.speakers = speakers
	dialog_player.dialogs = dialogs


func _ready():
	if Data.save_found:
		if Data.npc_dialog_index.has(npc_name):
			dialog_index = Data.npc_dialog_index[npc_name]
	else:
		set_dialogs()
#	var speakers = []
#	for i in dialogs.size():
#		speakers.append(npc_name)
#	dialog_player.speakers = speakers
#	dialog_player.dialogs = dialogs
	$Popup.hide()
	$HUD/DialogPlayer.stop()
	if npc_texture:
		sprite.texture = npc_texture


func _process(delta):
	if path and path.size():
		move_path(delta)
	handle_animation()


#func move_along_path(distance):
#	var start_point = position
#	for i in range(path.size()):
#		handle_path_anim(path[0])
#		var distance_to_next = start_point.distance_to(path[0])
#		if distance <= distance_to_next and distance >= 0.0:
#			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
#			break
#		elif distance < 0.0:
#			position = path[0]
#			walking_on_path = false
#			break
#		distance -= distance_to_next
#		start_point = path[0]
#		path.remove(0)


func move_path(delta):
	var point = path[0]
	
	if position.distance_squared_to(point) < 10.0:
		path.remove(0)
	else:
		walk((point - position).normalized())

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
			anim_player.current_animation = ("idle_right")
		elif anim_player.current_animation == "move_left":
			anim_player.current_animation = ("idle_left")
	if velocity.y > 0:
		$AnimationPlayer.play("move_down")
	elif velocity.y < 0:
		$AnimationPlayer.play("move_up")
	else:
		if anim_player.current_animation == "move_down":
			anim_player.current_animation = ("idle_down")
		elif anim_player.current_animation == "move_up":
			anim_player.current_animation = ("idle_up")


func walk(direction):
	velocity = direction * speed
	walking = true


func stop_walking():
	walking = false


func player_around(body):
	if not trigger_talk:
		return
	if not can_talk:
		return
	if body.name == "Player":
		player_around = true
		$Popup.show()


func player_not_around(body):
	if not trigger_talk:
		return
	if not can_talk:
		return
	if body.name == "Player":
		player_around = false
		$Popup.hide()
		$HUD/DialogPlayer.stop()


func _input(event):
	if event.is_action_pressed("talk") and player_around:
		if npc_name == "LeMarr" and not Data.can_talk_with["LeMarr"]:
			return
		$HUD/DialogPlayer.play()


func dialog_player_stopped():
	$Popup.hide()
	set_dialogs()
	Data.npc_dialog_index[npc_name] = dialog_index
	player_around = false
	if npc_name == "LeMarr":
		if dialog_index == 0:
			Data.can_talk_with["LeMarr"] = false
		if dialog_index == 1:
			Data.spawn_wrench_iron_coil = false
	if npc_name == "Bortus" and dialog_index == 0:
		Data.spawn_wrench_iron_coil = true



func _on_MoveRandom_timeout():
	set_path([position + Vector2(30, 0).rotated(TAU * randf())])
