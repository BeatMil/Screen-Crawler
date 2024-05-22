extends Control




func _ready():
	pass
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	get_viewport().transparent_bg = true


func _physics_process(_delta):
	pass
	# get_window().mouse_passthrough_polygon = $Waifu/Polygon2D.polygon


