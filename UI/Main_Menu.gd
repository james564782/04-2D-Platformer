extends Control


func _ready():
	pass


func _on_Play_pressed():
	get_tree().change_scene("res://GameScenes/Scene1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
