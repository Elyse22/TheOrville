extends KinematicBody2D

const ACCELERATION = 400
const MAX_SPEED = 70
const FRICTION = 500

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var anim_player = $CustomAnimations

var player_name = ""


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		anim_player.play("walk_right")
	elif input_vector.x < 0:
		anim_player.play("walk_left")
	elif input_vector.y > 0:
		anim_player.play("walk_down")
	elif input_vector.y < 0:
		anim_player.play("walk_up")
	else:
		anim_player.stop()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity) 


func _ready():
	load_custom_character()
	#self.global_position = Global.player_initial_map_position


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
