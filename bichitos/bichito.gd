extends KinematicBody2D


const Poof = preload("res://bichitos/poof.tscn")


signal died

var target setget _set_target
func _set_target(new_target):
	if target == new_target:
		return
	
	if target != null:	
		target.disconnect("picked", self, "_on_target_picked")
	
	target = new_target
	
	if target != null:
		target.connect("picked", self, "_on_target_picked")
	
	
func _ready():
	connect("input_event", self, "_on_input_event")
	

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("mouse_left"):
		var poof = Poof.instance()
		poof.position = position
		get_parent().add_child(poof)
		
		emit_signal("died", self)		
		queue_free()


func _on_target_picked(bichito):
	if bichito != self:
		_set_target(null)
