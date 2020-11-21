extends Node

export var level_num = 1
var can_advance = false
var start_time

onready var control = $Control
onready var level_label = find_node("Cleared")
onready var time_label = find_node("Time")
onready var press_any_key = find_node("PressAnyKey")


func _ready():
	level_label.text = "Level " + str(level_num) + " cleared"


func start():
	start_time = OS.get_ticks_msec()
	
func show_time():
	var time = (OS.get_ticks_msec() - start_time) / 1000
	Counter.time += time
	
	var minutes = time / 60
	var seconds = time - minutes * 60
	time_label.text = str(minutes) + ":" + str(seconds).pad_zeros(2)
	
	control.show()
	
	yield(get_tree().create_timer(3), "timeout")
	
	can_advance = true
	press_any_key.show()
	
	
func _input(event):
	if can_advance:
		if event is InputEventKey or event is InputEventMouseButton:
			SceneLoader.next_level()	
	
