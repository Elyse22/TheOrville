extends KinematicBody2D

export var npc_name = ""
export (Texture) var npc_texture

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer

var velocity = Vector2.ZERO
var speed = 250
var walking = false


func _ready():
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


