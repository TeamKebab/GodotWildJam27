extends KinematicBody2D


const Poof = preload("res://bichitos/poof.tscn")

signal died

var target setget _set_target
func _set_target(new_target):
	if target == new_target:
		return
	
	if target != null:	
		target.disconnect("picked", self, "_on_target_picked")
		target.disconnect("rotated", self, "_on_target_rotated")
	
	target = new_target
	
	if target != null:
		target.connect("picked", self, "_on_target_picked")
		target.connect("rotated", self, "_on_target_rotated")
	

onready var id : int = Counter.new_bichito()
onready var _state_machine = $StateMachine	

onready var _work_area = find_parent("Level").find_node("WorkArea")

func _ready():
	connect("input_event", self, "_on_input_event")
	

func get_available_letters() -> Array:
	return []


func pursue(new_target):
	_set_target(new_target)
	_state_machine._change_state("Pursuing")


func pick():
	pass
	

func die():
	var poof = Poof.instance()
	poof.position = position
	get_parent().add_child(poof)
	
	_state_machine._change_state("Idle")
	
	emit_signal("died", self)		
	queue_free()

		
func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("mouse_left"):
		die()


func _on_target_picked(bichito):
	if bichito != null:
		print("bichito " + String(bichito.id) + " picked letter " + bichito.target.letter)
	
	if bichito != self:
		_state_machine._change_state("Idle")
		_set_target(null)


func _on_target_rotated():
	pass
