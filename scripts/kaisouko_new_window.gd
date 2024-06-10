extends Node2D

# See? I'm even commenting this for you. Hmph!

# @onready var _ClickPolygon: Polygon2D = $"ClickableAreaGon"
@onready var offset: Vector2
var sprite_offset = Vector2(50, -110)
var mouse_pos: Vector2


signal move_across

# Config
var is_following_mouse = false


func _ready():
	pass
	#get_window().mouse_passthrough = true
	# Enable pass through mouse thingy XD
	#get_window().mouse_passthrough_polygon = _ClickPolygon.polygon

	# Set position
	# position = Vector2(0, DisplayServer.screen_get_size().y) + sprite_offset

	# Set first animation
	$AnimationPlayer.play("wave")


func _process(_delta):
	pass
	# # Debug labels
	# $MousePosLabel.text = str(mouse_pos)
	# $PosLabel.text = str(position)
	# $RandomLabel.text = str(offset)

	# # Get mouse pos
	# mouse_pos = get_viewport().get_mouse_position()

	# if is_following_mouse == true:
	# 	# stop getting offset when mouse is dragged
	# 	position = mouse_pos - offset
	# elif is_following_mouse == false:
	# 	# get offset when mouse is not drag
	# 	offset = mouse_pos - position

	# # flip image if goes to right side of the screen
	# ## floor() is to ignore divide integer warning ∑d(°∀°d) 
	# if position.x > (DisplayServer.screen_get_size().x / floor(2)):
	# 	scale.x = -0.5
	# else:
	# 	scale.x = 0.5


func _physics_process(_delta):
	pass
	# _update_polygon_position()


# detect mouse click
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			is_following_mouse = true
		elif !event.pressed and event.button_index == 1:
			is_following_mouse = false

		if event.pressed and event.button_index == 2:
				$AnimationPlayer.play("move_out")
				await $AnimationPlayer.animation_finished
				_move_across_screen()


## Updates the clickable area, preventing inputs from passing through the
## window outside of the defined region.
# func _update_polygon_position() -> void:
# 	# get polygon position
# 	var click_polygon: PackedVector2Array = _ClickPolygon.polygon
# 	## convert them to global
# 	for vec_i in range(click_polygon.size()):
# 		click_polygon[vec_i] = to_global(click_polygon[vec_i])

# 	# then tell windows to draw it
# 	get_window().mouse_passthrough_polygon = click_polygon


func flip_horizontal():
	scale.x *= -1


func look_right():
	scale.x = 0.575


func look_left():
	scale.x = -0.575


func _move_across_screen():
	position.x = DisplayServer.screen_get_size().x - position.x


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "move_in":
		$AnimationPlayer.play("wave")
	elif anim_name == "move_out": ## play move_out then move_in
		$AnimationPlayer.play("move_in")
		emit_signal("move_across")
