extends Control


func _ready():
	pass
	var window: Window = get_window()
	
	# Setting the viewport width and height from the project settings still
	# displays the boot splash, which is undesirable for a transparent app.
	# To avoid this, set the viewport width and height from the project
	# settings to 0, and then use the two functions provided below. You can
	# read the documentation for these functions to learn about what they do.
	window.size = Vector2i(DisplayServer.screen_get_size() + Vector2i(1, 1))
	window.position = DisplayServer.screen_get_position()


	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	get_viewport().transparent_bg = true
