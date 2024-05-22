extends Node2D

# See? I'm even commenting this for you. Hmph!

@onready var _ClickPolygon: Polygon2D = $"gon"


# Config
var is_following_mouse = false


func _ready():
	pass
	# Enable pass through mouse thingy XD
	get_window().mouse_passthrough_polygon = $"gon".polygon


func _process(_delta):
	if is_following_mouse == true:
		var mouse_pos = get_viewport().get_mouse_position()
		position = mouse_pos


func _physics_process(_delta):
	pass
	_update_polygon_position()


# detect mouse click
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			is_following_mouse = true
		else:
			is_following_mouse = false


## Updates the clickable area, preventing inputs from passing through the
## window outside of the defined region.
func _update_polygon_position() -> void:
	# get polygon position
	var click_polygon: PackedVector2Array = _ClickPolygon.polygon
	## convert them to global
	for vec_i in range(click_polygon.size()):
		click_polygon[vec_i] = to_global(click_polygon[vec_i])

	# then tell windows to draw it
	get_window().mouse_passthrough_polygon = click_polygon
