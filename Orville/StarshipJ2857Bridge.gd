extends Node2D



func _ready():
	Global.player_initial_map_position = Vector2(100,149.5)
	Data.go_to_shuttlecraft = true
	Data.objective = "Find Tomolen"
