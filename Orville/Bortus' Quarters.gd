extends Node2D


func _process(_delta):
	$IronCoil.visible = Data.spawn_wrench_iron_coil
	$Wrench.visible = Data.spawn_wrench_iron_coil
