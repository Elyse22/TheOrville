extends KinematicBody2D

signal path_finished

export var npc_name = ""
export (Texture) var npc_texture
export (Array, String) var dialogs
export (Array, String) var speakers_dialogs
export var trigger_talk = true

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
onready var dialog_player = $HUD/DialogPlayer

var velocity = Vector2.ZERO
export var speed = 50
var walking = false
var player_around = false
var path = []
export var dialog_index = -1
var can_talk = true
export var move_random: bool = true
export var sitting: bool = false setget _set_sitting
func _set_sitting(value):
	sitting = value
	
	if not is_inside_tree():
		yield(self, "ready")
	
	$CollisionShape2D.disabled = sitting

export var movement_cooldown: float = 0.0

func set_path(new_path):
	path = new_path


func set_dialogs():
	if not dialog_player:
		yield(self, "ready")
	if dialogs.size() == 0:
		return
#	if dialog_index >= dialogs.size() -1:
#		return
#	dialog_index += 1
	var speakers = speakers_dialogs
	if speakers.size() < dialogs.size():
		while speakers.size() < dialogs.size():
			speakers.append(npc_name)
	dialog_player.speakers = speakers
	dialog_player.dialogs = dialogs


func _ready():
	set_dialogs()
	if Data.save_found:
		if Data.npc_dialog_index.has(npc_name):
			dialog_index = Data.npc_dialog_index[npc_name]
#	var speakers = []
#	for i in dialogs.size():
#		speakers.append(npc_name)
#	dialog_player.speakers = speakers
#	dialog_player.dialogs = dialogs
	$Popup.hide()
	$HUD/DialogPlayer.hide()
	if npc_texture:
		sprite.texture = npc_texture
	
	if move_random:
		$MoveRandom.start()
	else:
		walk_custom_path()


func walk_custom_path():
	var new_path = []
	for node in $CustomPath.get_children():
		new_path.push_back(node.position)
	set_path(new_path)


func reverse_path():
	var new_path = []
	for v in path:
		new_path.push_front(v)
	set_path(new_path)


func _process(delta):
	if movement_cooldown <= 0.0:
		if $MoveCooldown.time_left == 0.0 and path.size() and not player_around:
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
			if move_random and path.size() and not $CustomPath.get_child_count():
				next_path_pt()

var direction := "down"

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
	
	if custom_anim_playing:
		return
	
	if velocity.length_squared() >= 1.0:
		anim_player.play("move_" + direction)
	elif sitting:
		anim_player.play("sit_right")
	else:
		anim_player.play("idle_" + direction)


func walk(direction):
	if not sitting:
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
		if move_random:
			$MoveCooldown.start(0.0)
		$Popup.show()


func player_not_around(body):
	if not trigger_talk:
		return
	if not can_talk:
		return
	if body.name == "Player":
		player_around = false
		$Popup.hide()
		if move_random:
			$MoveCooldown.stop()
		$HUD/DialogPlayer.stop()


func _input(event):
	if event.is_action_pressed("talk") and player_around:
		if npc_name == "LeMarr" and not Data.can_talk_with["LeMarr"]:
			return
		if move_random:
			$MoveCooldown.start(0.0)
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
	if $CustomPath.get_child_count():
		var node = $CustomPath.get_children()[int(rand_range(0.0, $CustomPath.get_child_count()))]
		set_path([node.position])
	else:
		var direction = Vector2(40, 0).rotated(PI / 2.0 * floor(rand_range(0.0, 4.0)))
		set_path([position + direction])



func sit(pos, dir):
	self.sitting = true
	global_position = pos
	direction = dir


var custom_anim_playing := false
func custom_animation(animation):
	anim_player.play(animation)
	custom_anim_playing = true


func _on_AnimationPlayer_animation_finished(anim_name):
	custom_anim_playing = false
