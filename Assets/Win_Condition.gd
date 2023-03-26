extends Area2D


func _on_Win_Condition_body_entered(body):
	if body.name == "Player":
		Global.win = true
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
