extends KinematicBody2D


const Poof = preload("res://bichitos/poof.tscn")

var target

func _ready():
	connect("input_event", self, "_on_input_event")
	

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		var poof = Poof.instance()
		poof.position = position
		get_parent().add_child(poof)
		
		queue_free()


