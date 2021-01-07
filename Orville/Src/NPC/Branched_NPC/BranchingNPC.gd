extends KinematicBody2D

export var npc_name = ""
export (Texture) var npc_texture
export var trigger_talk = true
export (Array, String) var condition_items

export (Array, Array, String) var branch_dialogs

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


func set_path(new_path):
	path = new_path
	walking_on_path = true


func set_dialogs():
	if not dialog_player:
		yield(self, "ready")
	if branch_dialogs.size() == 0:
		return
	#if dialog_index >= branch_dialogs.size() -1:
	#	return
	var speakers = []
	for i in branch_dialogs[dialog_index].size():
		speakers.append(npc_name)
	dialog_player.speakers = speakers
	dialog_player.dialogs = branch_dialogs[dialog_index]


func _ready():
#	if Data.save_found:
#		if Data.npc_dialog_index.has(npc_name):
#			dialog_index = Data.npc_dialog_index[npc_name]
#	else:
#		set_dialogs()
#	var speakers = []
#	for i in dialogs.size():
#		speakers.append(npc_name)
#	dialog_player.speakers = speakers
#	dialog_player.dialogs = dialogs
	$Popup.hide()
	$HUD/DialogPlayer.hide()
	if npc_texture:
		sprite.texture = npc_texture


func _process(_delta):
	handle_animation()
	if walking_on_path:
		var move_distance = speed * _delta
		move_along_path(move_distance)


func move_along_path(distance):
	var start_point = position
	for i in range(path.size()):
		handle_path_anim(path[0])
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			walking_on_path = false
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)


func handle_path_anim(point):
	if point.y > position.y:
		if anim_player.current_animation != "move_down":
			anim_player.play("move_down")
	elif point.y < position.y:
		if anim_player.current_animation != "move_up":
			anim_player.play("move_up")
	elif point.x > position.x:
		if anim_player.current_animation != "move_right":
			anim_player.play("move_right")
	elif point.x < position.x:
		if anim_player.current_animation != "move_left":
			anim_player.play("move_left")

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
	if not trigger_talk:
		return
	if not can_talk:
		return
	if body.name == "Player":
		player_around = true
		if $HUD/DialogPlayer:
			$Popup.show()


func player_not_around(body):
	if not trigger_talk:
		return
	if not can_talk:
		return
	if body.name == "Player":
		player_around = false
		$Popup.hide()
		if $HUD/DialogPlayer:
			$HUD/DialogPlayer.hide()


func _input(event):
	if event.is_action_pressed("talk") and player_around:
		if npc_name == "LeMarr" and not Data.can_talk_with["LeMarr"]:
			return
		var has_all_items = true
		for condition_item in condition_items:
			if not Data.inventory_has(condition_item):
				has_all_items = false
		dialog_index = 1 if has_all_items else 0
		set_dialogs()
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

