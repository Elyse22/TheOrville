extends KinematicBody2D
class_name Player

const ACCELERATION = 500
const MAX_SPEED = 75
const FRICTION = 500

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var anim_player = $CustomAnimations

var allow_portal_travel = false

var player_name = ""

var frame_count = 0

var direction = "down"

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector.x > 0:
		direction = "right"
	elif input_vector.x < 0:
		direction = "left"
	elif input_vector.y > 0:
		direction = "down"
	elif input_vector.y < 0:
		direction = "up"
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		anim_player.play("walk_" + direction)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		anim_player.play("idle_" + direction)

	velocity = move_and_slide(velocity)

	frame_count += 1
	if frame_count == 3:
		allow_portal_travel = true


func _ready():
	load_custom_character()
	#self.global_position = Global.player_initial_map_position
	if Global.in_lift:
		print("Lift")
		Global.in_lift = false
		for lift in get_tree().get_nodes_in_group("lift"):
			print("Going to lift at " + str(lift.global_position))
			self.global_position = lift.global_position


func load_custom_character():
	$Character/Skin.texture = load(Data.character.skin_style)
	$Character/Beard.texture = load(Data.character.beard_style)
	$Character/Hair.texture = load(Data.character.hair_style)
	$Character/Mustache.visible = Data.character.mustache_style
	$Character/Beard.modulate = Data.character.beard_color
	$Character/EyeBrows.modulate = Data.character.hair_color
	$Character/Hair.modulate = Data.character.hair_color
	$Character/Pupil.modulate = Data.character.pupil_color
	$Character/Shirt.modulate = Data.character.shirt_color
	player_name = Data.character.name
