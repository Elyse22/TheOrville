extends KinematicBody2D

signal dialogue_finished(index)

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
export var dialog_index = -1
var can_talk = true

export var movement_cooldown: float = 0.0


func set_path(new_path):
	path = new_path


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
	
	walk_custom_path()


func walk_custom_path():
	var new_path = []
	for node in $CustomPath.get_children():
		new_path.push_back(node.position)
	set_path(new_path)


func _process(delta):
	if movement_cooldown <= 0.0:
		if path.size() and not player_around:
			move_path(delta)
		else:
			velocity = Vector2.ZERO
	else:
		movement_cooldown -= delta
	
	handle_animation()


func next_path_pt():
	path.remove(0)
	velocity = Vector2.ZERO
	if path.size() == 0:
		emit_signal("path_finished")


func move_path(delta):
	var point = path[0]

	if position.distance_squared_to(point) < 100.0:
		next_path_pt()
	else:
		walk((point - position).normalized())

func _physics_process(_delta):
	if walking:
		velocity = move_and_slide(velocity, Vector2.UP)
		if get_slide_count():
			velocity = Vector2.ZERO

export var direction := "down"

func handle_animation():
	if velocity.length_squared() >= 1.0:
		var angle = rad2deg(velocity.angle())
		if angle >= -30 and angle <= 30:
			direction = "right"
		elif angle >= -150 and angle <= -30:
			direction = "up"
		elif angle >= 30 and angle <= 150:
			direction = "down"
		else:
			direction = "left"
	
	if velocity.length_squared() >= 1.0:
		anim_player.play("move_" + direction)
	else:
		anim_player.play("idle_" + direction)


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
	emit_signal("dialogue_finished", dialog_index)
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

