extends Node2D

@onready var _MainWindow: Window = get_window()
@onready var offset: Vector2
@onready var waifu: Node2D = $"Waifu"
var sprite_offset = Vector2(140, -265)
var mouse_pos: Vector2
var is_following_mouse = false


func _ready():
	waifu.connect("move_across", _move_across_screen) # move across screen baby! XD

	# ------------ MAIN WINDOW SETUP ------------
	# Enable per-pixel transparency, required for transparent windows but has a performance cost
	# Can also break on some systems
	ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed", true)
	# Set the window settings - most of them can be set in the project settings
	_MainWindow.borderless = true		# Hide the edges of the window
	_MainWindow.unresizable = true		# Prevent resizing the window
	_MainWindow.always_on_top = true	# Force the window always be on top of the screen
	_MainWindow.gui_embed_subwindows = false # Make subwindows actual system windows <- VERY IMPORTANT
	_MainWindow.transparent = true		# Allow the window to be transparent
	# Settings that cannot be set in project settings
	_MainWindow.transparent_bg = true	# Make the window's background transparent

	# _MainWindow.size = Vector2(220, 470)
	_MainWindow.position = Vector2(0, DisplayServer.screen_get_size().y + sprite_offset.y)
	# _MainWindow.position = Vector2(0, DisplayServer.screen_get_size().y + sprite_offset.y)

	Engine.max_fps = 120 ## This stops pc lagging


	print("===", DisplayServer.screen_get_size())
	print("size: ", _MainWindow.size)
	print("pos: ", _MainWindow.position)


func _process(_delta):
	mouse_pos = DisplayServer.mouse_get_position()

	# offset make smoother mouse grab
	if is_following_mouse == true:
		# stop getting offset when mouse is dragged
		_MainWindow.position = mouse_pos - offset
	elif is_following_mouse == false:
		# get offset when mouse is not drag
		offset = Vector2i(mouse_pos) - _MainWindow.position
	
	# check which side of the screen
	if _MainWindow.position.x > ((DisplayServer.screen_get_size().x - sprite_offset.x) / floor(2)):
		waifu.look_left()
	else:
		waifu.look_right()


# detect mouse click
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			is_following_mouse = true
		elif !event.pressed and event.button_index == 1:
			is_following_mouse = false


func _move_across_screen():
	# print("pos_now: ", _MainWindow.position)
	_MainWindow.position.x = DisplayServer.screen_get_size().x - sprite_offset.x - _MainWindow.position.x
	# print("pos_later: ", _MainWindow.position)
	# waifu.flip_horizontal()
