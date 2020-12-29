extends Node2D

var npc_one_path
var npc_two_path
var npc_three_path

onready var nav_2d = $Navigation2D
onready var npc_one = $NPC1
onready var npc_two = $NPC2
onready var npc_three = $NPC3
onready var end_one = $End1
onready var end_two = $End2
onready var end_three = $End3


func _ready():
	npc_one_path = nav_2d.get_simple_path(npc_one.global_position, end_one.global_position)
	npc_two_path = nav_2d.get_simple_path(npc_two.global_position, end_two.global_position)
	npc_three_path = nav_2d.get_simple_path(npc_three.global_position, end_three.global_position)
	npc_one.set_path(npc_one_path)
	npc_two.set_path(npc_two_path)
	npc_three.set_path(npc_three_path)
