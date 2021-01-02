tool
extends Area2D

export var id := ""

export(String, FILE) var next_scene_path = ""
export(Vector2) var player_spawn_location = Vector2.ZERO
export(String) var player_direction = "down"

func enable():
	Data.enable_portal(id)
func disable():
	Data.disable_portal(id)


func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for the portal to work"
	else:
		return ""



func _on_Portal_body_entered(body):
	if id in Data.disabled_portals:
		return
	if body is Player:
		if not body.allow_portal_travel:
			return
		Global.player_facing_direction = player_direction
		Global.player_initial_map_position = player_spawn_location
		if get_tree().change_scene(next_scene_path) != OK:
			# error handling here
			print("Error: Unavailable scene!")
