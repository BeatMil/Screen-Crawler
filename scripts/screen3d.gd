extends Node3D


func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	# get_viewport().transparent_bg = true

