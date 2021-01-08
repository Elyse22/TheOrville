extends Button

export var paused: bool setget _set_paused

func _set_paused(value):
	paused = value
	
	if not is_inside_tree():
		yield(self, "ready")
	
	get_tree().paused = paused
	visible = paused

func _ready():
	self.paused = false
	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible=!visible 
		
		


func _on_Button_pressed():
	get_tree().quit()
