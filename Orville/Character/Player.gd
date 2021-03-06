extends KinematicBody2D
class_name Player

const ACCELERATION = 500
const MAX_SPEED = 75
const FRICTION = 500

var velocity = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var anim_player = $CustomAnimations

var allow_portal_travel = false

var player_name = ""

var frame_count = 0
var direction = "down"

export var sitting := false

export var can_use_scanner := false

var equipped = null
func unequip():
	equipped = null
	$Character/OnHand.visible = false
func equip(name, sprite):
	equipped = name
	$Character/OnHand.texture = sprite
	$Character/OnHand.visible = true

func try_equip(name, sprite):
	if equipped:
		unequip()
	else:
		equip(name, sprite)

func _physics_process(delta):
	if sitting:
		anim_player.play("sit_" + direction)
	else:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if velocity.length_squared() > 1.0:
			var angle = rad2deg(velocity.angle())
			if angle >= -30 and angle <= 30:
				direction = "right"
			elif angle >= -150 and angle <= -30:
				direction = "up"
			elif angle >= 30 and angle <= 150:
				direction = "down"
			else:
				direction = "left"
			
			anim_player.play("walk_" + direction)
		else:
			anim_player.play("idle_" + direction)
		
		if input_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", input_vector)
			animationTree.set("parameters/Run/blend_position", input_vector)
			animationState.travel("Run")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		velocity = move_and_slide(velocity)

	frame_count += 1
	if frame_count == 3:
		allow_portal_travel = true
	
	Data.player_position = position


func _ready():
	load_custom_character()
	if Global.player_initial_map_position:
		global_position = Global.player_initial_map_position
		Global.player_initial_map_position = null
	if Global.player_facing_direction:
		direction = Global.player_facing_direction
		Global.player_facing_direction = null
	if Global.in_lift:
		Global.in_lift = false
		for lift in get_tree().get_nodes_in_group("lift"):
			global_position = lift.global_position


func _process(_delta):
	if Data.objective:
		$HUD/Objective.visible = true
		$HUD/Objective/PanelContainer/Label.text = str(Data.objective)
	else:
		$HUD/Objective.visible = false
	
	
	if Input.is_action_just_pressed("equip_comms_scanner"):
		if can_use_scanner:
			try_equip("Comms Scanner", load("res://Assets/Scanner.png"))


#func _input(event):
#	if event.is_action_pressed("sit") and sitting:
#		sitting = false


func load_custom_character():
	$Character/Skin.texture = load(Data.character.skin_style)
	$Character/Beard.texture = load(Data.character.beard_style)
	$Character/Hair.texture = load(Data.character.hair_style)
	$Character/Mustache.visible = not not Data.character.mustache_style
	$Character/Mustache.modulate = Data.character.mustache_color
	$Character/Beard.modulate = Data.character.beard_color
	$Character/EyeBrows.modulate = Data.character.hair_color
	$Character/Hair.modulate = Data.character.hair_color
	$Character/Pupil.modulate = Data.character.pupil_color
	$Character/Shirt.modulate = Data.character.shirt_color
	player_name = Data.character.name




