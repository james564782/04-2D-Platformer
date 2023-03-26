extends Camera2D

var Player
var parallax_rate = 0.005
var z = 0.35 #basic is 0.35, camera zoom
var width
var height
var viewport_size

var current_camera_zone

func _ready():
	Player = get_node_or_null("/root/Scene/Player")
	viewport_size = get_viewport_rect().size * z
	width = viewport_size.x
	height = viewport_size.y * 2.0
	zoom = Vector2(z, z)
	$Background.visible = true

func _physics_process(delta):
	Player = get_node_or_null("/root/Scene/Player")
	if not Player == null:
		set_camera_placement()
		set_background_placement()

func set_camera_zone(var zone):
	current_camera_zone = zone
	if not Player == null:
		set_camera_placement()
		set_background_placement()

func set_camera_placement():
	var pos = Player.global_position
	if (not current_camera_zone == null):
		var xRightBorder = current_camera_zone.get_position().x - current_camera_zone.get_extents().x + width
		var xLeftBorder = current_camera_zone.get_position().x + current_camera_zone.get_extents().x - width
		var yBottomBorder = current_camera_zone.get_position().y + current_camera_zone.get_extents().y - height
		var yTopBorder = current_camera_zone.get_position().y - current_camera_zone.get_extents().y + height
		print(str(Vector2(round(pos.x), round(pos.y))) + " is between: " + str(yBottomBorder) + " and " + str(yTopBorder))
		var xPos = clamp(pos.x, xLeftBorder, xRightBorder)
		var yPos = clamp(pos.y, yBottomBorder, yTopBorder)
		pos = Vector2(xPos, yPos)
	global_position = pos

func set_background_placement():
	var pos = Player.global_position
	$Background.global_position = Vector2(round((pos.x / (624 * $Background.scale.x)) - 0.5) * (624 * $Background.scale.x), round((pos.y / (624 * $Background.scale.y)) - 0.5)* (624 * $Background.scale.y))
