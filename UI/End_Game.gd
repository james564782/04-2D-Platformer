extends Control

func _ready():
	if Global.win == false:
		$Label.text = "You lost! Your final score was " + str(Global.score) + " points" #Player must find the exit to win
	else:
		$Label.text = "You win! Your final score was " + str(Global.score * 2) + " points"


func _on_Play_pressed():
	Global.reset()
	var _scene = get_tree().change_scene("res://GameScenes/Scene1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
