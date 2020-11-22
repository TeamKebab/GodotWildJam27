extends Node

const MUSIC = preload("res://levels/variation_1.ogg")


func _ready():
	Music.play_from_start(MUSIC)
	
	
func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		SceneLoader.next_level()	
