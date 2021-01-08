extends PanelContainer

export var paused: bool setget _set_paused
func _set_paused(value):
	paused = value
	
	if not is_inside_tree():
		yield(self, "ready")
	
	get_tree().paused = paused
	visible = paused

func _ready():
	self.paused = false

func save_game():
	Data.save_game()
	$CenterContainer/VBoxContainer/Message.text = "GAME SAVED!"
	yield(get_tree().create_timer(3), "timeout")
	$CenterContainer/VBoxContainer/Message.text = ""

func back():
	self.paused = false

func quit():
	get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.paused = !self.paused
