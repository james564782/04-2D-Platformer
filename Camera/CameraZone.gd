extends Area2D

var CameraNode
var CameraZone

func _ready():
	CameraNode = get_node_or_null("/root/Scene/ComplexCamera")
	CameraZone = get_node_or_null("/root/Scene/Zones/" + name)

func _on_CameraZone_body_entered(body):
	print("detected something")
	if body.name == "Player":
		print("detected player")
		if not CameraNode == null and not CameraZone == null:
			CameraNode.set_camera_zone(CameraZone)
